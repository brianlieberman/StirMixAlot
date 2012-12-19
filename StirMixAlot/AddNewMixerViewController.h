//
//  AddNewMixerViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/13/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddNewMixerViewControllerDelegate;
@interface AddNewMixerViewController : UIViewController

//handle keyboard actions
- (IBAction)keyboardDone:(id)sender;


//handler for saveButton
- (IBAction)savePressed:(id)sender;

//UI Elements
@property (strong, nonatomic) IBOutlet UITextField *catName;
@property (strong, nonatomic) IBOutlet UITextField *nameMixerName;


//delegate for save action
@property (nonatomic, assign) id <AddNewMixerViewControllerDelegate> delegate;

@end

@protocol AddNewMixerViewControllerDelegate

- (void)addNewMixerViewController:(AddNewMixerViewController *)controller didFinishWithSave:(BOOL)save;

@end
