//
//  XJRemoteConfigProtocol.h
//  News
//
//  Created by XJIMI on 2018/12/9.
//  Copyright © 2018 setn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XJRemoteConfigManagerProtocol <NSObject>

@optional

- (void)loadConfigData;

- (BOOL)isLoaded;


@end

NS_ASSUME_NONNULL_END
