//
//  LaunchViewController.m
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJLaunchViewController.h"
#import "XJLaunchManager.h"

@interface XJLaunchViewController ()

@end

@implementation XJLaunchViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [XJLaunchManager shared].launchViewControllerStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    if ([XJLaunchManager shared].launchViewControllerStatusBarStyle == -1) {
        return YES;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return NO;
}

@end
