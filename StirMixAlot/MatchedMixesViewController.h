//
//  MatchedMixesViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/16/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchedMixesViewController : UITableViewController

//data structs for handling table events 
@property (strong, nonatomic) NSMutableDictionary *rootAllMixes;
@property (strong, nonatomic) NSMutableArray *matchedMixes;
@property (strong, nonatomic) NSMutableArray *selectedMixers;




@end
