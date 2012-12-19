//
//  AppDelegate.h
//  StirMixAlot
//
//  Created by Brian Lieberman on 11/1/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableDictionary *customMixes;
@property (strong, nonatomic) NSMutableDictionary *mixersDictGlobal;
@property (strong, nonatomic) NSMutableDictionary *allMixes;

@end
