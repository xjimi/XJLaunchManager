//
//  RemoteConfigManager.m
//  News
//
//  Created by XJIMI on 2018/12/6.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJRemoteConfigManager.h"

@interface XJRemoteConfigManager ()

@property (nonatomic, assign) NSInteger currentNum;

@end

@implementation XJRemoteConfigManager

+ (instancetype)shared
{
    static XJRemoteConfigManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[XJRemoteConfigManager alloc] init];
    });
    return shared;
}

- (void)loadConfigDataWithCompletion:(ConfigCompletionBlock)completion
{
    self.configCompletionBlock = completion;
    [self loadConfigData];
}

- (void)loadConfigData
{
    if (self.config)
    {
        [self loadAdConfigData];
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"取得 Config data ");
        if (self.currentNum == 1) {
            self.config = [RemoteConfigModel new];
        }

        [self loadAdConfigData];

    });
    
}

- (void)loadAdConfigData
{
    if (self.adConfig)
    {
        [RemoteCONFIG dispatchConfigBlock];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"取得 AD Config data ");
        weakSelf.adConfig = [NSMutableDictionary dictionary];
        [weakSelf dispatchConfigBlock];

        self.currentNum ++;

    });
}

- (BOOL)isLoaded {
    return self.config;
}

- (void)dispatchConfigBlock {
    !self.configCompletionBlock ? : self.configCompletionBlock([self isLoaded]);
}

@end
