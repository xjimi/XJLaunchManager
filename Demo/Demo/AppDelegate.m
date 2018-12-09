//
//  AppDelegate.m
//  Demo
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 XJIMI. All rights reserved.
//

#import "AppDelegate.h"
#import "XJLaunchManager.h"
#import "ViewController.h"
#import "LaunchCustomView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [XJLaunchManager setLaunchSourceType:LaunchSourceTypeScreen];
    [XJLaunchManager initWithLaunchViewClass:LaunchCustomView.class];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
