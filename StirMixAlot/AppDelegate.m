//
//  AppDelegate.m
//  StirMixAlot
//
//  Created by Brian Lieberman on 11/1/12.
//  Copyright (c) 2012 Brian Lieberman. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    


    [self loadMixers];
    [self loadCustomMixes];
    [self loadAllMixes];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    //save current data to documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"mixers.plist"];
    
    [self.mixersDictGlobal writeToFile:plistFilePathInDocumentsDirectory atomically:YES];
    
    plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"customMixes.plist"];
    [self.customMixes writeToFile:plistFilePathInDocumentsDirectory atomically:YES];
    
    plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"allMixes.plist"];
    [self.allMixes writeToFile:plistFilePathInDocumentsDirectory atomically:YES];


}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)loadMixers
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"mixers.plist"];    // Instantiate NSDictionary object with loaded plist file
    
    NSMutableDictionary *tempPointsDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInDocumentsDirectory];
    
    if (!tempPointsDict) {
        /*
         In this case, the CountryCities.plist file does not exist in the documents directory.
         This will happen when the user launches the app for the very first time.
         Therefore, read the plist file from the main bundle to show the user some example favorite cities.
         
         Get the file path to the CountryCities.plist file in application's main bundle.
         */
        NSString *plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"mixers" ofType:@"plist"];
        
        // Instantiate a modifiable dictionary and initialize it with the content of the plist file in main bundle
        tempPointsDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    }
    self.mixersDictGlobal = tempPointsDict;
    
}

-(void)loadCustomMixes
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"customMixes.plist"];    // Instantiate NSDictionary object with loaded plist file
    
    NSMutableDictionary *tempMixes = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInDocumentsDirectory];
    
    if (!tempMixes) {
        /*
         In this case, the plist file does not exist in the documents directory.
         This will happen when the user launches the app for the very first time.
         Therefore, read the plist file from the main bundle to show the user some example favorite cities.
         
         Get the file path to the CountryCities.plist file in application's main bundle.
         */
        NSString *plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"customMixes" ofType:@"plist"];
        
        // Instantiate a modifiable dictionary and initialize it with the content of the plist file in main bundle
        tempMixes = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    }
    self.customMixes = tempMixes;
    
}

-(void)loadAllMixes
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *plistFilePathInDocumentsDirectory = [documentsDirectoryPath stringByAppendingPathComponent:@"allMixes.plist"];    // Instantiate NSDictionary object with loaded plist file
    
    NSMutableDictionary *tempMixes = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInDocumentsDirectory];
    
    if (!tempMixes) {
        /*
         In this case, the plist file does not exist in the documents directory.
         This will happen when the user launches the app for the very first time.
         Therefore, read the plist file from the main bundle to show the user some example favorite cities.
         
         Get the file path to the CountryCities.plist file in application's main bundle.
         */
        NSString *plistFilePathInMainBundle = [[NSBundle mainBundle] pathForResource:@"allMixes" ofType:@"plist"];
        
        // Instantiate a modifiable dictionary and initialize it with the content of the plist file in main bundle
        tempMixes = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePathInMainBundle];
    }
    self.allMixes = tempMixes;
    
}
@end
