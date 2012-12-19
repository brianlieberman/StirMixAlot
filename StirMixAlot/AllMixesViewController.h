//
//  AllMixesViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/15/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllMixesViewController : UITableViewController

//data stucts for table operations
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableDictionary *rootAllMixes;
@property (strong, nonatomic) NSArray *allMixes;
@property (strong, nonatomic) NSArray *searchResults;

@end
