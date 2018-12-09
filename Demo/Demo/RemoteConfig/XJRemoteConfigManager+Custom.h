//
//  RemoteConfigManager+Extension.h
//  News
//
//  Created by XJIMI on 2018/12/7.
//  Copyright © 2018 setn. All rights reserved.
//

#import "XJRemoteConfigManager.h"
#import "RemoteConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AdConfigCompletionBlock)(NSMutableDictionary *adConfig);

@interface XJRemoteConfigManager (Custom) < XJRemoteConfigManagerProtocol >

@property (nonatomic, strong) RemoteConfigModel *config;

@property (nonatomic, strong) NSMutableDictionary *adConfig;

@end

NS_ASSUME_NONNULL_END
