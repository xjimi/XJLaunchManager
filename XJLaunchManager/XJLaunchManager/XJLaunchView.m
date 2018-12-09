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

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = [UIScreen mainScreen].bounds;
        [self addNotifications];
    }
    return self;
}

- (void)addNotifications
{
    __weak typeof(self)weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [weakSelf dispatchSourceCancelSafe:weakSelf.skipTimer];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [weakSelf loadConfigData];

    }];
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
                [self intoAppWindow];
                return;
            }
            _duration--;
        });
    });
    dispatch_resume(_skipTimer);
}

- (void)adSkipDidPassDuration:(NSInteger)duration {
}

- (void)intoAppWindow
{
    [self dispatchSourceCancelSafe:self.skipTimer];
    [[XJLaunchManager shared] intoAppWindow];
}

- (void)dispatchSourceCancelSafe:(dispatch_source_t)time
{
    if(time)
    {
        dispatch_source_cancel(time);
        time = nil;
    }
}

@end
