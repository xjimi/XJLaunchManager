//
//  RemoteConfigManager.h
//  News
//
//  Created by XJIMI on 2018/12/6.
//  Copyright © 2018 setn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

#define RemoteCONFIG [XJRemoteConfigManager shared]

typedef void(^ConfigCompletionBlock)(BOOL configLoaded);

typedef void(^AdConfigCompletionBlock)(NSMutableDictionary *adConfig);

@interface XJRemoteConfigManager : NSObject

@property (nonatomic, copy) ConfigCompletionBlock configCompletionBlock;

@property (nonatomic, strong) RemoteConfigModel *config;

@property (nonatomic, strong) NSMutableDictionary *adConfig;

+ (instancetype)shared;

- (void)loadConfigDataWithCompletion:(ConfigCompletionBlock)completion;

- (void)dispatchConfigBlock;

- (BOOL)isLoaded;

@end

NS_ASSUME_NONNULL_END
