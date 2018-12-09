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

@interface XJLaunchManager : NSObject

@property (nonatomic, assign) LaunchSourceType launchSourceType;

+ (instancetype)shared;

+ (void)setLaunchSourceType:(LaunchSourceType)launchSourceType;

+ (void)initWithLaunchViewClass:(Class)launchViewClass;

+ (void)setRootViewControllerClass:(Class _Nullable)rootViewControllerClass;

+ (void)initWithLaunchViewClass:(Class)launchViewClass
        rootViewControllerClass:(Class _Nullable)rootViewControllerClass;

- (void)intoAppWindow;

@end

NS_ASSUME_NONNULL_END
