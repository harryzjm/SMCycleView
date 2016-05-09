//
//  AppDelegate.m
//  SMCycleView
//
//  Created by Magic on 23/2/2016.
//  Copyright © 2016 Magic. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
