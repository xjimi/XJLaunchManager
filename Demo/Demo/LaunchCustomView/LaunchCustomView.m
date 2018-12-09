//
//  LaunchCustomView.m
//  News
//
//  Created by XJIMI on 2018/12/8.
//  Copyright © 2018 setn. All rights reserved.
//

#import "LaunchCustomView.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "XJRemoteConfigManager.h"

typedef void(^RetryBlock)(void);

@interface LaunchErrorView : UIView

@property (nonatomic, copy) RetryBlock retryBlock;

@end

@implementation LaunchErrorView

- (instancetype)initWithRetryBlock:(RetryBlock)block
{
    self = [super init];
    if (self)
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.retryBlock = block;
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [label setFont:[UIFont systemFontOfSize:16.0f]];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"未連線至網路\n請確認網路狀態並重試";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(.8);
        make.left.equalTo(self).mas_offset(20);
        make.right.equalTo(self).mas_offset(-20);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.contentEdgeInsets = UIEdgeInsetsMake(8, 20, 8, 20);
    [btn.layer setBorderWidth:1];
    [btn.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn setTitle:@"重試" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action_retry) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(40);
        make.centerX.equalTo(self);
    }];
}

- (void)action_retry {
    !self.retryBlock ? : self.retryBlock();
}

@end


@interface LaunchAdView : UIView

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UIImageView *bottomLogoView;


@end

@implementation LaunchAdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    UIImageView *adImageView = [[UIImageView alloc] init];
    adImageView.backgroundColor = [UIColor whiteColor];
    adImageView.contentMode = UIViewContentModeScaleAspectFill;
    adImageView.clipsToBounds = YES;
    [self addSubview:adImageView];
    self.adImageView = adImageView;
    [self.adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.8);
    }];
  
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(adImageView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

@end


@interface LaunchCustomView ()

@property (nonatomic, strong) LaunchErrorView *launchErrorView;

@property (nonatomic, strong) LaunchAdView *launchAdView;

@end

@implementation LaunchCustomView

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    __weak typeof(self)weakSelf = self;
    _launchErrorView = [[LaunchErrorView alloc] initWithRetryBlock:^{
        [weakSelf loadConfigData];
    }];
    self.launchErrorView.alpha = 0.0f;
    [self addSubview:self.launchErrorView];
    
    self.launchAdView.alpha = 0.0f;
    [self addSubview:self.launchAdView];
    [self.launchAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [[AFNetworkReachabilityManager sharedManager]
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status > 0)
         {
             if (![RemoteCONFIG isLoaded]) {
                 [weakSelf loadConfigData];
             }
         }
         else if (status < 1)
         {
             [weakSelf errorViewHidden:NO];
         }
         
     }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)loadConfigData
{
    [self errorViewHidden:YES];
    __weak typeof(self)weakSelf = self;
    [RemoteCONFIG loadConfigDataWithCompletion:^(BOOL configLoaded) {
        
        if (configLoaded)
        {
            [weakSelf loadAdImageWithUrl:@"https://www.robinwesleyinstrumentals.com/wp-content/uploads/2018/06/Large-rectangles@05x.jpg"];
        }
        else if (!RemoteCONFIG.config && !RemoteCONFIG.adConfig)
        {
            [weakSelf errorViewHidden:NO];
        }
        
    }];
}

- (void)loadAdImageWithUrl:(NSString *)url
{
    if (!url.length)
    {
        [self intoAppWindow];
        return;
    }
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imageData];
    if (image)
    {
        self.launchAdView.adImageView.image = image;
        [UIView animateWithDuration:.2 animations:^{
            
            self.launchAdView.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            
            [self startSkipTimerWithDuration:3];
            
        }];
    }
    else
    {
        [self intoAppWindow];
    }
}

- (void)intoAppWindow
{
    ViewController *vc = [[ViewController alloc] init];
    [self intoAppWithViewController:vc];
}

- (void)errorViewHidden:(BOOL)hidden
{
    [self bringSubviewToFront:self.launchErrorView];
    [UIView animateWithDuration:.2 animations:^{
        self.launchErrorView.alpha = !hidden;
    }];
}

- (void)adSkipDidPassDuration:(NSInteger)duration
{
    NSLog(@"adSkipDidPassDuration : %ld", (long)duration);
    if (!duration) {
        [self intoAppWindow];
    }
}

- (LaunchAdView *)launchAdView
{
    if (!_launchAdView) {
        _launchAdView = [[LaunchAdView alloc] init];
    }
    return _launchAdView;
}

@end
