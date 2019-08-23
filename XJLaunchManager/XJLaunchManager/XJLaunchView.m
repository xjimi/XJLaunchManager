//
//  XJLaunchView.m
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJLaunchView.h"

@interface XJLaunchView ()

@property(nonatomic,copy) dispatch_source_t skipTimer;

@end

@implementation XJLaunchView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = [UIScreen mainScreen].bounds;
        [self createLaunchSourceView];
        [self addNotifications];
    }
    return self;
}

- (void)createLaunchSourceView
{
    XJLaunchSourceView *launchSourceView = [[XJLaunchSourceView alloc] initWithLaunchSourceType:[XJLaunchManager shared].launchSourceType];
    [self addSubview:launchSourceView];
}

- (void)loadConfigData {
}

- (void)startSkipTimerWithDuration:(NSInteger)duration
{
    __block NSInteger _duration = duration; //default
    NSTimeInterval period = 1.0;
    _skipTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_skipTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_skipTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{

            [self adSkipDidPassDuration:_duration];
            if(_duration == 0)
            {
                [self dispatchSourceCancelSafe:self.skipTimer];
                return;
            }
            _duration--;
        });
    });
    dispatch_resume(_skipTimer);
}

- (void)adSkipDidPassDuration:(NSInteger)duration {
}

- (void)intoAppWithViewController:(UIViewController * _Nullable)viewController
{
    [self dispatchSourceCancelSafe:self.skipTimer];
    [[XJLaunchManager shared] intoAppWithViewController:viewController];
}

- (void)dispatchSourceCancelSafe:(dispatch_source_t)time
{
    if(time)
    {
        dispatch_source_cancel(time);
        time = nil;
    }
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    [self loadConfigData];
}

@end
