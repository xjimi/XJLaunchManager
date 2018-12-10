//
//  LaunchViewController.m
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJLaunchViewController.h"

@interface XJLaunchViewController ()

@end

@implementation XJLaunchViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return NO;
}

@end
