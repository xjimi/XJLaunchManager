//
//  RemoteConfigManager.h
//  News
//
//  Created by XJIMI on 2018/12/6.
//  Copyright © 2018 setn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJRemoteConfigManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define RemoteCONFIG [XJRemoteConfigManager shared]

typedef void(^ConfigCompletionBlock)(BOOL configLoaded);

@interface XJRemoteConfigManager : NSObject < XJRemoteConfigManagerProtocol >

@property (nonatomic, copy) ConfigCompletionBlock configCompletionBlock;

+ (instancetype)shared;

- (void)loadConfigDataWithCompletion:(ConfigCompletionBlock)completion;

- (void)dispatchConfigBlock;

@end

NS_ASSUME_NONNULL_END
