//
//  CWAppDelegate.m
//  ChipmunkWrapper
//
//  Created by Jakub Knejzlik on 25/02/14.
//  Copyright (c) 2014 Jakub Knejzlik. All rights reserved.
//

#import "CWAppDelegate.h"

#import "CWTestViewController.h"

@implementation CWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[CWTestViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
