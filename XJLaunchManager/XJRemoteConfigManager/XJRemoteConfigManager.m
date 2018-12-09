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

- (void)dispatchConfigBlock {
    !self.configCompletionBlock ? : self.configCompletionBlock([self isLoaded]);
}

@end
