//
//  CustomMixesViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/14/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "CustomMixesViewController.h"
#import "AppDelegate.h"
#import "MixDetailViewController.h"

@interface CustomMixesViewController ()

@end

@implementation CustomMixesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Obtain an object reference to the App Delegate object
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.rootCustomMixes = appDelegate.customMixes;
    
    self.customMixes  = [[self.rootCustomMixes allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    //remove badge
    [[[[[self tabBarController] tabBar] items] objectAtIndex:1]
     setBadgeValue:nil];
    
    //hide scope bar
    self.searchBar.showsScopeBar = NO;
    self.searchDisplayController.searchBar.scopeButtonTitles = nil;
    
    [self.tableView reloadData];

}

-(void) viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


//get the number of cells to display
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.customMixes count];
        
    }
}

//get cell for each particular tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"customMixCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.customMixes objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //perform segue
  
        [self performSegueWithIdentifier: @"showMixDetail" sender: self];
    
}

//perform filtering for search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    self.searchResults = [self.customMixes filteredArrayUsingPredicate:resultPredicate];
}

//perform search and reload data
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMixDetail"]) {
        
        MixDetailViewController *mixDetailViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        
        //determine if selected from search results
        if ([self.searchDisplayController isActive]) {
            
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            //pass data
           mixDetailViewController.selectedMixName = [self.searchResults objectAtIndex:indexPath.row];
            mixDetailViewController.selectedMix = [self.rootCustomMixes objectForKey:[self.searchResults objectAtIndex:indexPath.row]];
            
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            
            //pass data
           mixDetailViewController.selectedMixName = [self.customMixes objectAtIndex:indexPath.row];
            mixDetailViewController.selectedMix = [self.rootCustomMixes objectForKey:[self.customMixes objectAtIndex:indexPath.row]];
        }
    }
    
}
@end
