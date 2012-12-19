//
//  AddNewMixerViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/13/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "AddNewMixerViewController.h"

@interface AddNewMixerViewController ()

@end

@implementation AddNewMixerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keyboardDone:(id)sender
{
    [sender resignFirstResponder];  // Deactivate the keyboard
    
}

- (IBAction)savePressed:(id)sender {
    
    [self.delegate addNewMixerViewController:self didFinishWithSave:YES];
}

@end
