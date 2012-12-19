//
//  AllMixesViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/15/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "AllMixesViewController.h"
#import "AppDelegate.h"
#import "AllMixesDetailViewController.h"

@interface AllMixesViewController ()

@end

@implementation AllMixesViewController

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
    
    self.rootAllMixes = appDelegate.allMixes;
    
    self.allMixes  = [[self.rootAllMixes allKeys] sortedArrayUsingSelector:@selector(compare:)];

    
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

//get the number of cells to display
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.allMixes count];
        
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
        cell.textLabel.text = [self.allMixes objectAtIndex:indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //perform segue
    
    [self performSegueWithIdentifier: @"allMixDetail" sender: self];
    
}

//perform filtering for search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    self.searchResults = [self.allMixes filteredArrayUsingPredicate:resultPredicate];
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


//handle segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"allMixDetail"]) {
        
        AllMixesDetailViewController *mixDetailViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        
        //determine if selected from search results
        if ([self.searchDisplayController isActive]) {
            
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            //pass data
            mixDetailViewController.selectedMixName = [self.searchResults objectAtIndex:indexPath.row];
            mixDetailViewController.selectedMix = [self.rootAllMixes objectForKey:[self.searchResults objectAtIndex:indexPath.row]];
            
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            
            //pass data
            mixDetailViewController.selectedMixName = [self.allMixes objectAtIndex:indexPath.row];
            mixDetailViewController.selectedMix = [self.rootAllMixes objectForKey:[self.allMixes objectAtIndex:indexPath.row]];
        }
    }
    
}


@end
