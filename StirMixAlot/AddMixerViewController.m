//
//  AddMixerViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/13/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "AddMixerViewController.h"

@interface AddMixerViewController ()

@end

@implementation AddMixerViewController

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
    
    self.mixerLabel.text = self.selectedMixer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//handler for save action 
- (IBAction)addMixPressed:(id)sender {
    
    
    
    //call delegate to inform save action
    [self.delegate addMixerViewController:self didFinishWithAdd:YES];

}

- (IBAction)keyboardDone:(id)sender
{
    [sender resignFirstResponder];  // Deactivate the keyboard
    
}

@end
