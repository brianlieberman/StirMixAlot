//
//  MatchedMixesViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/16/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "MatchedMixesViewController.h"
#import "AppDelegate.h"
#import "MatchedMixDetailViewController.h"

@interface MatchedMixesViewController ()

@end

@implementation MatchedMixesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.rootAllMixes = appDelegate.allMixes;
    self.matchedMixes = [NSMutableArray arrayWithArray:[[self.rootAllMixes allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //add all mixes to array then search and remove those without matching ingredients.
    
    int mixCount = [self.matchedMixes count];
    
    for(int i = 0; i < mixCount; i++)
    {
        
        
        for(int j = 0; j < [self.selectedMixers count]; j++)
        {
            
            NSMutableDictionary * currentMixIngredients = [[self.rootAllMixes objectForKey:[self.matchedMixes objectAtIndex:i]] objectForKey:@"Ingredients"];
            
            NSArray * ingredientsArray = [[currentMixIngredients allKeys] sortedArrayUsingSelector:@selector(compare:)];
            
            if(([currentMixIngredients objectForKey:[self.selectedMixers objectAtIndex:j]] == nil) || ([ingredientsArray count] != [self.selectedMixers count]))
            {
                [self.matchedMixes removeObjectAtIndex:i];
                i--;
                mixCount--;
                break;
            }
            
        }
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//get the number of cells to display
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.matchedMixes count];
}

//get cell for each particular tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"matchedMixCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.matchedMixes objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}

//handle row selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showMatchedMixDetail" sender:self ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMatchedMixDetail"]) {
        
        MatchedMixDetailViewController *mixDetailViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        mixDetailViewController.selectedMix  = [self.rootAllMixes objectForKey:[self.matchedMixes objectAtIndex:indexPath.row]];
        
        mixDetailViewController.selectedMixName = [self.matchedMixes objectAtIndex:indexPath.row];
        
        
        
    }
}




@end
