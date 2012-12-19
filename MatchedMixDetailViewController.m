//
//  MatchedMixDetailViewController.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 12/16/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "MatchedMixDetailViewController.h"

@interface MatchedMixDetailViewController ()

@end

@implementation MatchedMixDetailViewController

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
    
    //set title
    self.title = self.selectedMixName;
    
    //extract and set ingredients
    NSDictionary *ingredients = [self.selectedMix objectForKey:@"Ingredients"];
    NSArray *ingredientsArray = [[ingredients allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for(int i = 0; i < [ingredientsArray count]; i++)
    {
        NSString * item = [ingredientsArray objectAtIndex:i];
        NSString * amount = [ingredients objectForKey:[ingredientsArray objectAtIndex:i]];
        
        self.recipe.text = [NSString stringWithFormat:@"%@%@ %@\n\n",self.recipe.text, amount, item];
    }
    
    
    
    //load saved picture from documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"%@.png", self.selectedMixName] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    self.mixImage.image = image;
    
    //set to default if picture doesn't exsist
    if(self.mixImage.image == nil)
    {
        UIImage *local = [UIImage imageNamed:self.selectedMixName];
        if(local == nil)
        {
            self.mixImage.image = [UIImage imageNamed:@"noImage.jpg"];
        }
        else
        {
            self.mixImage.image = local;
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
