//
//  LaunchManager.h
//  News
//
//  Created by XJIMI on 2018/12/5.
//  Copyright © 2018 setn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XJLaunchSourceView.h"

#define kNotificationDidIntoAppWindow @"kNotificationDidIntoAppWindow"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LaunchStatusBarStyle) {
    LaunchStatusBarStyleHidden = -1,
    LaunchStatusBarStyleDefault = UIStatusBarStyleDefault,
    LaunchStatusBarStyleLightContent = UIStatusBarStyleLightContent,
};

@interface XJLaunchManager : NSObject

@property (nonatomic, assign, readonly) LaunchSourceType launchSourceType;

@property (nonatomic, assign, readonly) LaunchStatusBarStyle launchViewControllerStatusBarStyle;


+ (instancetype)shared;

+ (void)setLaunchSourceType:(LaunchSourceType)launchSourceType;

+ (void)setLaunchViewControllerStatusBarStyle:(LaunchStatusBarStyle)statusBarStyle;

+ (void)setIntoAppAnimateDuration:(NSTimeInterval)duration;

+ (void)initWithLaunchViewClass:(Class)launchViewClass;

+ (void)setRootViewControllerClass:(Class)rootViewControllerClass;

+ (void)initWithLaunchViewClass:(Class)launchViewClass
        rootViewControllerClass:(Class)rootViewControllerClass;

- (void)intoAppWithViewController:(UIViewController * _Nullable)viewController;

@end

NS_ASSUME_NONNULL_END
