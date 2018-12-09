//
//  XJLaunchView.h
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "XJLaunchManager.h"
#import "XJRemoteConfigManager.h"
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface XJLaunchView : UIView

- (void)startSkipTimerWithDuration:(NSInteger)duration;

- (void)adSkipDidPassDuration:(NSInteger)duration;

- (void)intoAppWindow;

@end

NS_ASSUME_NONNULL_END
