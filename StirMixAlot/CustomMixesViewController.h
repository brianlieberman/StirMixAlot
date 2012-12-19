//
//  CustomMixesViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/14/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMixesViewController : UITableViewController

//data structures for manipulating table data
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableDictionary *rootCustomMixes;
@property (strong, nonatomic) NSArray *customMixes;
@property (strong, nonatomic) NSArray *searchResults;
@end
