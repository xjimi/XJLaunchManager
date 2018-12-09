//
//  XJLaunchSourceView.h
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LaunchSourceType) {
    LaunchSourceTypeImage,
    LaunchSourceTypeScreen
};

@interface XJLaunchSourceView : UIImageView

- (instancetype)initWithLaunchSourceType:(LaunchSourceType)launchSourceType;

@end

NS_ASSUME_NONNULL_END
