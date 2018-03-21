//
//  XKPlayerController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlayerController.h"
#import "XKMusicControlView.h"
#import "XKMusicCoverView.h"

@interface XKPlayerController ()

/// 背景视图
@property (nonatomic, strong) UIImageView *bgImageView;
/// 封面视图
@property (nonatomic, strong) XKMusicCoverView *coverView;
/// 音乐控制视图
@property (nonatomic, strong) XKMusicControlView *controlView;

@end

@implementation XKPlayerController

+ (instancetype)sharedInstance {
    static XKPlayerController *playerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerVC = [[XKPlayerController alloc] init];
    });
    return playerVC;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [XKAppDelegateHelper hideAnimationButton];
}

#pragma mark -- 配置导航栏
- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {
    return YES;
}

- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {
    return YES;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage qmui_imageWithColor:UIColorClear];
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    self.titleView.title = @"浪漫恋星空";
    self.titleView.subtitle = @"123";
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.controlView];
    
    /// 布局
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kTopHeight);
        make.bottom.equalTo(self.controlView.mas_top).offset(20);
    }];
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(170);
    }];
}

#pragma mark -- 懒加载

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImageView.image = UIImageMake(@"cm2_fm_bg-ip6");
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.userInteractionEnabled = NO;
        _bgImageView.clipsToBounds = YES;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.frame = _bgImageView.bounds;
        [_bgImageView addSubview:effectView];
    }
    return _bgImageView;
}

- (XKMusicCoverView *)coverView {
    if (!_coverView) {
        _coverView = [[XKMusicCoverView alloc] init];;
//        _coverView.delegate = self;
    }
    return _coverView;
}

- (XKMusicControlView *)controlView {
    if (!_controlView) {
        _controlView = [[XKMusicControlView alloc] init];
    }
    return _controlView;
}

@end
