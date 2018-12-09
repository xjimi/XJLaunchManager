//
//  RemoteConfigManager+Extension.m
//  News
//
//  Created by XJIMI on 2018/12/7.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJRemoteConfigManager+Custom.h"
#import <objc/runtime.h>

static const char *kConfigPropertyKey = "kConfigPropertyKey";

static const char *kAdConfigPropertyKey = "kAdConfigPropertyKey";

@implementation XJRemoteConfigManager (Custom)

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

- (RemoteConfigModel *)config {
    return objc_getAssociatedObject(self, kConfigPropertyKey);
}

- (void)setConfig:(RemoteConfigModel *)config {
    objc_setAssociatedObject(self,kConfigPropertyKey, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)adConfig {
    return objc_getAssociatedObject(self, kAdConfigPropertyKey);
}

- (void)setAdConfig:(NSMutableDictionary *)adConfig {
    objc_setAssociatedObject(self, kAdConfigPropertyKey, adConfig, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
