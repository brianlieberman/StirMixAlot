//
//  MakeMixViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 11/27/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "MakeMixViewController.h"
#import "AppDelegate.h"
#import "MakeMixCell.h"


@interface MakeMixViewController ()

@end

@implementation MakeMixViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    // Obtain an object reference to the App Delegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    //initialize data structures
	self.rootMixersDict = appDelegate.mixersDictGlobal;
    self.rootCustomMixes = appDelegate.customMixes;
    self.rootAllMixes = appDelegate.allMixes;
    
	self.arrayOriginal=[self.rootMixersDict valueForKey:@"Objects"];
    
	
	self.arForTable=[[NSMutableArray alloc] init];
	[self.arForTable addObjectsFromArray:self.arrayOriginal];
    
    self.currentIngredients = [[NSMutableDictionary alloc] init];
    
    
    //detect if camera is present, disable button if no camera found.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
    {
        [self.pictureButton setEnabled:NO];
        [self.pictureButton setTitle:@"Pictures Disabled" forState:UIControlStateDisabled];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Alert" message:@"Camera not detected. Please use a device with a camera to use media features." delegate:self
                              cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alert show];
    }

	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

//get number of rows in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.arForTable count];
}

// Customize the appearance of table view cells.
- (MakeMixCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MakeMixCell *cell = (MakeMixCell *)[tableView dequeueReusableCellWithIdentifier:@"mixCell"];
	
	cell.mixLabel.text=[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"name"];
	[cell setIndentationLevel:[[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //bold root categories
    if([[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue] == 0)
    {
        [cell.mixLabel setFont:[UIFont boldSystemFontOfSize:17]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        [ cell.mixLabel setFont:[UIFont systemFontOfSize:17]];
        
    }
	
    return cell;
}

//handle selection of rows in table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	NSDictionary *d=[self.arForTable objectAtIndex:indexPath.row];
	if([d valueForKey:@"Objects"]) {
		NSArray *ar=[d valueForKey:@"Objects"];
		
		BOOL isAlreadyInserted=NO;
		
		for(NSDictionary *dInner in ar ){
			NSInteger index=[self.arForTable indexOfObjectIdenticalTo:dInner];
			isAlreadyInserted=(index>0 && index!=NSIntegerMax);
			if(isAlreadyInserted)
            {
                break;
            }
		}
		
		if(isAlreadyInserted) {
			[self miniMizeThisRows:ar];
		} else {
            
            //check if leaf and handle selection
            if( [ar count] < 1)
            {
                self.selectedMixer = [[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"name"];
                [self performSegueWithIdentifier:@"addMixer" sender:self];
            }
            
			NSUInteger count=indexPath.row+1;
			NSMutableArray *arCells=[NSMutableArray array];
			for(NSDictionary *dInner in ar ) {
				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
				[self.arForTable insertObject:dInner atIndex:count++];
			}
			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
		}
	}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//recursive function to minimize a selected row in the table
-(void)miniMizeThisRows:(NSArray*)ar{
	
	for(NSDictionary *dInner in ar ) {
		NSUInteger indexToRemove=[self.arForTable indexOfObjectIdenticalTo:dInner];
		NSArray *arInner=[dInner valueForKey:@"Objects"];
        
		if(arInner && [arInner count]>0){
			[self miniMizeThisRows:arInner];
		}
        
		if([self.arForTable indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
			[self.arForTable removeObjectIdenticalTo:dInner];
			[self.mixTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                   [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                   ]
                                 withRowAnimation:UITableViewRowAnimationRight];
		}
        
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

//handle segues for different selected actions
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"addMixer"]) {
        
        // Obtain the object reference of the destination view controller
        AddMixerViewController *addMixerViewController = [segue destinationViewController];
        
        [addMixerViewController setSelectedMixer:self.selectedMixer];
        addMixerViewController.delegate = self;
    }
    
    if ([segueIdentifier isEqualToString:@"addNewMixer"]) {
        
        // Obtain the object reference of the destination view controller
        AddNewMixerViewController *addNewMixerViewController = [segue destinationViewController];
        
        addNewMixerViewController.delegate = self;
    }
}

//save button pushed for new ingredient
- (void)addMixerViewController:(AddMixerViewController *)controller didFinishWithAdd:(BOOL)save
{
    if(save)
    {
        [self.currentIngredients setObject:controller.mixAmount.text forKey:controller.selectedMixer];
        
        //pop view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//save button pressed for new mixer
- (void)addNewMixerViewController:(AddNewMixerViewController *)controller didFinishWithSave:(BOOL)save
{
    
    //determine if category exists
    if(save)
    {
        bool catExists = NO;
        NSMutableArray * root = [self.rootMixersDict objectForKey:@"Objects"];
        NSMutableDictionary * currentCat;
        
        for(int i = 0; i <[root count]; i++  )
        {
            currentCat = [root objectAtIndex:i];
            
            //check if category already exisits
            if([[currentCat objectForKey:@"name"] isEqualToString:controller.catName.text] )
            {
                catExists = YES;
                break;
                
            }
            
            
        }
        if(catExists)
        {
            //insert new item into existing cat dictionaey(level, name, objects)
            NSMutableArray * currentObjects = [currentCat objectForKey:@"Objects"];
            NSMutableDictionary * newItem = [[NSMutableDictionary alloc] init];
            
            [newItem setObject:controller.nameMixerName.text forKey:@"name"];
            [newItem setObject:[NSNumber numberWithInt:1] forKey:@"level"];
            [newItem setObject:[[NSArray alloc] init] forKey:@"Objects"];
            
            [currentObjects addObject:newItem];
        }
        else
        {
            //add new category for item
            NSMutableDictionary * newCat = [[NSMutableDictionary alloc] init];
            
            [newCat setObject:controller.catName.text forKey:@"name"];
            [newCat setObject:[NSNumber numberWithInt:0] forKey:@"level"];
            [newCat setObject:[[NSArray alloc] init] forKey:@"Objects"];
            
            NSMutableDictionary * newCatItem = [[NSMutableDictionary alloc] init];
            
            [newCatItem setObject:controller.nameMixerName.text forKey:@"name"];
            [newCatItem setObject:[NSNumber numberWithInt:1] forKey:@"level"];
            [newCatItem setObject:[[NSArray alloc] init] forKey:@"Objects"];
            
            NSMutableArray * items = [NSMutableArray arrayWithArray:[newCat objectForKey:@"Objects"]];
            
            //insert items in the proper order for the plist file
            [items addObject:newCatItem];
            [newCat setObject:items forKey:@"Objects"];
            [root addObject:newCat];
            
            //reinit the root struct
            [self.rootMixersDict setObject:root forKey:@"Objects"];
            
            
            self.arrayOriginal=[self.rootMixersDict valueForKey:@"Objects"];
            self.arForTable=[[NSMutableArray alloc] init];
            [self.arForTable addObjectsFromArray:self.arrayOriginal];
            
            
            
            
            
            
        }
        
        
        
        //pop view controller
        [self.navigationController popViewControllerAnimated:YES];
        [self.mixTable reloadData];
    }
}

//handler for new mixer button
- (IBAction)newMixerPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"addNewMixer" sender:self];
}

- (IBAction)keyboardDone:(id)sender
{
    [sender resignFirstResponder];  // Deactivate the keyboard
    
}

//takes view to camera
- (IBAction)takePicturePressed:(id)sender {
    
    //make sure name isn't blank as it is used for picture filename
    if(self.mixName.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Alert" message:@"Please enter a name for your mix" delegate:self
                              cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    //create new image picker and display it
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
   [self presentViewController:picker animated:YES completion:nil];
}

//handler for save button
- (IBAction)savePressed:(id)sender {
    
    //make sure name isn't blank as it is used for picture filename
    if(self.mixName.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Alert" message:@"Please enter a name for your mix" delegate:self
                              cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }
    
    
    
    //create new dict for drink
    NSMutableDictionary * newMix = [[NSMutableDictionary alloc] init];
    
    [newMix setObject:self.currentIngredients forKey:@"Ingredients"];
    
    [self.rootCustomMixes setObject:newMix forKey:self.mixName.text];
    [self.rootAllMixes setObject:newMix forKey:self.mixName.text];
    
    
    
    //update badges on tab for newly added drinks
    if([[[[[self tabBarController] tabBar] items] objectAtIndex:1] badgeValue] == nil) //set badge to 1
    {
        [[[[[self tabBarController] tabBar] items] objectAtIndex:1]
         setBadgeValue:@"1"];
        
     
    }
    else //increment badge
    {
     
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber = [f numberFromString:[[[[[self tabBarController] tabBar] items] objectAtIndex:1] badgeValue]];
        
        int badgeInt = [myNumber intValue] + 1;
        [[[[[self tabBarController] tabBar] items] objectAtIndex:1]
         setBadgeValue:[[NSNumber numberWithInt:badgeInt] stringValue]];
        
    }
    
    //reintialize data structures on save
    self.currentIngredients = [[NSMutableDictionary alloc] init];
    self.mixName.text = nil;
    
    //hide keyboard

        [self.mixName resignFirstResponder];  // Deactivate the keyboard
        

    
    
}

//Delegate method to save picture from camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    //obtaining saving path
    [self dismissViewControllerAnimated:YES completion:nil];

    UIImage* originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    
    NSData *pngData = UIImagePNGRepresentation(originalImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", self.mixName.text]]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
   }
@end
