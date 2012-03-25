//
//  AppDelegate.m
//  MobclixDemo
//
//  Created by Tyler White on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;

#pragma mark - Default Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Here we create our mainViewController which holds our table view and our ad view
    MainViewController *mainViewController = [[MainViewController alloc] init];
    [self.window setRootViewController:mainViewController];
    
    // I'm getting my mobclix app id from an external file that is in the .gitignore so that it's kept private ;-)
    // Just delete the following 5 lines and set your own applicationId.
    NSString *path = [[NSBundle mainBundle] bundlePath];
    path = [path stringByAppendingPathComponent:@"mobclix_application_id.plist"];;
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *applicationId = [dict valueForKey:@"application_id"];
    NSAssert(applicationId, @"Hey Chico! Set your Mobclix application ID in the app delegate.");
    
    // Initialize Mobclix with your application's ID!
    [Mobclix startWithApplicationId:applicationId];
    
    return YES;
}

@end
