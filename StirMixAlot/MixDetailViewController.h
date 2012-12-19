//
//  MixDetailViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/14/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixDetailViewController : UIViewController


//passed data from upstream
@property (strong, nonatomic) NSMutableDictionary *selectedMix;

@property (strong, nonatomic) NSString *selectedMixName;

//UI elements
@property (strong, nonatomic) IBOutlet UITextView *recipe;
@property (strong, nonatomic) IBOutlet UIImageView *mixImage;

@end
