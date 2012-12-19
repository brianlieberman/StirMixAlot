//
//  MixOnTapViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/15/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "MixOnTapViewController.h"
#import "AppDelegate.h"
#import "MatchedMixesViewController.h"

@interface MixOnTapViewController ()

@end

@implementation MixOnTapViewController

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
    //initialize data structures
	self.rootMixersDict = appDelegate.mixersDictGlobal;
    
    
    //get all available mixers
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    self.mixers = [[NSArray alloc] init];
    
    NSArray * original = [self.rootMixersDict valueForKey:@"Objects"];
    
    for(int i = 0; i < [original count]; i++)
    {
        NSDictionary * cat = [original objectAtIndex:i];
        NSArray * catItems = [cat valueForKey:@"Objects"];
        
        for(int j = 0; j < [catItems count]; j++)
        {
            NSDictionary *item = [catItems objectAtIndex:j];
            [temp addObject:[item objectForKey:@"name"]];
            
        }
    }
    
   //sort mixers into array for use in table
    self.mixers = [temp sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.selectedMixers = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//get the number of cells to display
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mixers count];
}

//get cell for each particular tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"mixOnTapCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.mixers objectAtIndex:indexPath.row];
    

    
    return cell;
}

//handle row selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //add selected item to array
    [self.selectedMixers addObject:[self.mixers objectAtIndex:indexPath.row]];
}

//handle row deslection
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedMixers removeObject:[self.mixers objectAtIndex:indexPath.row]];
}
- (IBAction)findMixPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"showFoundMixes" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showFoundMixes"]) {
        
       MatchedMixesViewController *matchedMixes = segue.destinationViewController;
        
        //pass user selections downstream
        matchedMixes.selectedMixers = self.selectedMixers;
    }
}
@end
