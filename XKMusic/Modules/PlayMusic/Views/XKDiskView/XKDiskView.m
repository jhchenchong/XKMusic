//
//  XKDiskView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDiskView.h"

@interface XKDiskView ()

@property (nonatomic, strong) LKImageView *imgView;

@end

@implementation XKDiskView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.diskImgView];
    [self.diskImgView addSubview:self.imgView];

    [self.diskImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(66);
        make.width.height.mas_equalTo(SCREEN_WIDTH - 80);
    }];
    
    CGFloat imgWH = SCREEN_WIDTH - 180;
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.diskImgView);
        make.width.height.mas_equalTo(imgWH);
    }];
    
    self.imgView.layer.cornerRadius  = imgWH * 0.5;
    self.imgView.layer.masksToBounds = YES;
}

- (void)setImgurl:(NSString *)imgurl {
    _imgurl = imgurl;
    self.imgView.URL = imgurl;
}

- (UIImageView *)diskImgView {
    if (!_diskImgView) {
        _diskImgView = [UIImageView new];
        _diskImgView.image = [UIImage imageNamed:@"cm2_play_disc-ip6"];
    }
    return _diskImgView;
}

- (LKImageView *)imgView {
    if (!_imgView) {
        _imgView = [[LKImageView alloc] init];
        _imgView.defaultImage = UIImageMake(@"cm2_fm_bg-ip6");
    }
    return _imgView;
}

@end
