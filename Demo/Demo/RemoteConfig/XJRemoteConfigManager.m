//
//  RemoteConfigManager.m
//  News
//
//  Created by XJIMI on 2018/12/6.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJRemoteConfigManager.h"

@interface XJRemoteConfigManager ()

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
    [self loadAdConfigData];
    
    if (self.config)
    {
        [RemoteCONFIG dispatchConfigBlock];
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"取得 Config data ");
        self.config = [RemoteConfigModel new];
        [RemoteCONFIG dispatchConfigBlock];
        
    });
    
}

- (void)loadAdConfigData
{
    if (self.adConfig) return;
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"取得 AD Config data ");
        weakSelf.adConfig = [NSMutableDictionary dictionary];
        [weakSelf dispatchConfigBlock];
        
    });
}

- (BOOL)isLoaded {
    return self.config && self.adConfig;
}

- (void)dispatchConfigBlock {
    !self.configCompletionBlock ? : self.configCompletionBlock([self isLoaded]);
}

@end
