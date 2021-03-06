//
//  LaunchManager.m
//  News
//
//  Created by XJIMI on 2018/12/5.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJLaunchManager.h"
#import "XJLaunchView.h"
#import "XJLaunchViewController.h"

@interface XJLaunchManager ()

@property (nonatomic, strong) UIWindow *launchWindow;

@property (nonatomic, strong) Class launchViewClass;

@property (nonatomic, strong) Class rootViewControllerClass;

@property (nonatomic, assign) LaunchSourceType launchSourceType;

@property (nonatomic, assign) LaunchStatusBarStyle launchViewControllerStatusBarStyle;

@property (nonatomic, assign) NSTimeInterval intoAppAnimateDuration;

@end

@implementation XJLaunchManager

+ (void)load {
    //[self shared];
}

+ (instancetype)shared
{
    static XJLaunchManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[XJLaunchManager alloc] init];
        shared.intoAppAnimateDuration = 0.3;
    });
    return shared;
}

/*
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
    return self;
}

- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    [self createLaunchWindow];
    NSLog(@"applicationDidFinishLaunchingNotification ----");
}
 */

+ (void)setLaunchViewControllerStatusBarStyle:(LaunchStatusBarStyle)statusBarStyle {
    [XJLaunchManager shared].launchViewControllerStatusBarStyle = statusBarStyle;
}

+ (void)setLaunchSourceType:(LaunchSourceType)launchSourceType {
    [XJLaunchManager shared].launchSourceType = launchSourceType;
}

+ (void)setIntoAppAnimateDuration:(NSTimeInterval)duration {
    [XJLaunchManager shared].intoAppAnimateDuration = duration;
}

+ (void)initWithLaunchViewClass:(Class)launchViewClass {
    [XJLaunchManager shared].launchViewClass = launchViewClass;
    [[XJLaunchManager shared] createLaunchWindow];
}

+ (void)setRootViewControllerClass:(Class)rootViewControllerClass {
    [XJLaunchManager shared].rootViewControllerClass = rootViewControllerClass;
}

+ (void)initWithLaunchViewClass:(Class)launchViewClass
        rootViewControllerClass:(Class)rootViewControllerClass
{
    [XJLaunchManager shared].launchViewClass = launchViewClass;
    [XJLaunchManager shared].rootViewControllerClass = rootViewControllerClass;
    [[XJLaunchManager shared] createLaunchWindow];
}

- (void)createLaunchWindow
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor blackColor];
    window.rootViewController = [[XJLaunchViewController alloc] init];
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    //[window makeKeyAndVisible];
    XJLaunchView *launchView = [[[XJLaunchManager shared].launchViewClass alloc] init];
    [window addSubview:launchView];
    self.launchWindow = window;
}

- (void)createAppWindowWithViewController:(UIViewController * _Nullable)viewController
{
    if (!viewController)
    {
        NSAssert([XJLaunchManager shared].rootViewControllerClass, @" 尚未設置 rootViewControllerClass ");
        viewController = [[[XJLaunchManager shared].rootViewControllerClass alloc] init];
    }
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor blackColor];
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
    [UIApplication sharedApplication].delegate.window = window;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidIntoAppWindow object:nil];
}

- (void)intoAppWithViewController:(UIViewController * _Nullable)viewController
{
    if ([UIApplication sharedApplication].delegate.window) return;
    [self createAppWindowWithViewController:viewController];
    [UIView animateWithDuration:self.intoAppAnimateDuration animations:^{

        self.launchWindow.alpha = 0;
        
    } completion:^(BOOL finished) {

        [self.launchWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if (obj)
            {
                [obj removeFromSuperview];
                obj = nil;
            }

        }];
        self.launchWindow.hidden = YES;
        self.launchWindow = nil;


    }];
}

@end
