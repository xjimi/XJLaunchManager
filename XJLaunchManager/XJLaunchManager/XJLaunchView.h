//
//  XJLaunchView.h
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJLaunchManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface XJLaunchView : UIView

- (void)loadConfigData;

- (void)startSkipTimerWithDuration:(NSInteger)duration;

- (void)adSkipDidPassDuration:(NSInteger)duration;

- (void)intoAppWithViewController:(UIViewController * _Nullable)viewController;

@end

NS_ASSUME_NONNULL_END
