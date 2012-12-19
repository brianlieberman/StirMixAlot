//
//  MixOnTapViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/15/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixOnTapViewController : UIViewController

//structures for managing table
@property (strong, nonatomic) NSMutableDictionary *rootMixersDict;
@property (strong, nonatomic) NSArray *mixers;
@property (strong, nonatomic) NSMutableArray *selectedMixers;

//handler for find mix button
- (IBAction)findMixPressed:(id)sender;

@end
