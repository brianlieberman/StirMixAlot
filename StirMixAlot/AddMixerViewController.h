//
//  AddMixerViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/13/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMixerViewControllerDelegate;
@interface AddMixerViewController : UIViewController


//passed selected mixer
@property (nonatomic, retain) NSString *selectedMixer;

//UI elements
@property (strong, nonatomic) IBOutlet UILabel *mixerLabel;

@property (strong, nonatomic) IBOutlet UITextField *mixAmount;

@property (nonatomic, assign) id <AddMixerViewControllerDelegate> delegate;

//handler for save button
- (IBAction)addMixPressed:(id)sender;

//handlers for keyboard actions
- (IBAction)keyboardDone:(id)sender;


@end

//delegate for save  action
@protocol AddMixerViewControllerDelegate

- (void)addMixerViewController:(AddMixerViewController *)controller didFinishWithAdd:(BOOL)save;

@end
