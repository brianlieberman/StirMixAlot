//
//  MakeMixViewController.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 11/27/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMixerViewController.h"
#import "AddNewMixerViewController.h"

@interface MakeMixViewController : UIViewController<AddMixerViewControllerDelegate, AddNewMixerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//root data structure holding all mix data
@property (strong, nonatomic) NSMutableDictionary *rootMixersDict;
@property (strong, nonatomic) NSMutableDictionary *rootCustomMixes;
@property (strong, nonatomic) NSMutableDictionary *rootAllMixes;

@property (strong, nonatomic) NSMutableDictionary *currentIngredients;

//table for displaying mixes
@property (strong, nonatomic) IBOutlet UITableView *mixTable;

//global value to pass selected index
@property (nonatomic) int selectedValueIndex;

@property (strong, nonatomic) IBOutlet UIButton *pictureButton;



//structures for managing dropdown dynamic table
@property (nonatomic, retain) NSArray *arrayOriginal;
@property (nonatomic, retain) NSMutableArray *arForTable;
@property (nonatomic, retain) NSString *selectedMixer;

-(void)miniMizeThisRows:(NSArray*)ar;

//handler for new mixer button
- (IBAction)newMixerPressed:(id)sender;

//handlers for keyboard actions
- (IBAction)keyboardDone:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *mixName;

//handler for picture button
- (IBAction)takePicturePressed:(id)sender;

//handler for save button
- (IBAction)savePressed:(id)sender;


@end
