//
//  XKMusicControlView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKMusicControlView.h"
#import "XKSliderView.h"

@interface XKMusicControlView ()<XKSliderViewDelegate>

@property (nonatomic, strong) QMUIButton *loveBtn;
@property (nonatomic, strong) QMUIButton *downloadBtn;
@property (nonatomic, strong) QMUIButton *commentBtn;
@property (nonatomic, strong) QMUIButton *moreBtn;

@property (nonatomic, strong) QMUIButton *playBtn;
@property (nonatomic, strong) QMUIButton *loopBtn;
@property (nonatomic, strong) QMUIButton *prevBtn;
@property (nonatomic, strong) QMUIButton *nextBtn;
@property (nonatomic, strong) QMUIButton *listBtn;

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) QMUILabel *currentLabel;
@property (nonatomic, strong) QMUILabel *totalLabel;
@property (nonatomic, strong) XKSliderView *slider;

@end

@implementation XKMusicControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.topView];
        [self.topView addSubview:self.loveBtn];
        [self.topView addSubview:self.downloadBtn];
        [self.topView addSubview:self.commentBtn];
        [self.topView addSubview:self.moreBtn];
        
        [self addSubview:self.sliderView];
        [self.sliderView addSubview:self.currentLabel];
        [self.sliderView addSubview:self.slider];
        [self.sliderView addSubview:self.totalLabel];
        
        [self addSubview:self.playBtn];
        [self addSubview:self.loopBtn];
        [self addSubview:self.prevBtn];
        [self addSubview:self.nextBtn];
        [self addSubview:self.listBtn];
        
        /// 布局
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(50);
        }];
        
        /// 计算按钮位置
        CGFloat btnWH  = 50;
        CGFloat leftM  = 50;
        CGFloat margin = (SCREEN_WIDTH - 4 * btnWH - 2 * leftM) / 3;
        
        [self.loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.topView);
            make.left.equalTo(self.topView).offset(leftM);
            make.width.mas_equalTo(btnWH);
        }];
        
        [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.topView);
            make.left.equalTo(self.loveBtn.mas_right).offset(margin);
            make.width.mas_equalTo(btnWH);
        }];
        
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.topView);
            make.left.equalTo(self.downloadBtn.mas_right).offset(margin);
            make.width.mas_equalTo(btnWH);
        }];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.topView);
            make.left.equalTo(self.commentBtn.mas_right).offset(margin);
            make.width.mas_equalTo(btnWH);
        }];
        
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(self.topView.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-60);
        }];
        
        [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.slider.mas_left).offset(-30);
            make.centerY.equalTo(self.sliderView.mas_centerY);
        }];
        
        [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.slider.mas_right).offset(30);
            make.centerY.equalTo(self.sliderView.mas_centerY);
        }];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-20);
            make.centerX.equalTo(self);
        }];
        
        [self.prevBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.playBtn.mas_left).offset(-20);
            make.centerY.equalTo(self.playBtn.mas_centerY);
        }];
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(20);
            make.centerY.equalTo(self.playBtn.mas_centerY);
        }];
        
        [self.loopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.prevBtn.mas_left).offset(-20);
            make.centerY.equalTo(self.playBtn.mas_centerY);
        }];
        
        [self.listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nextBtn.mas_right).offset(20);
            make.centerY.equalTo(self.playBtn.mas_centerY);
        }];
    }
    return self;
}

- (void)setStyle:(XKPlayerPlayStyle)style {
    switch (style) {
        case XKPlayerPlayStyleLoop:
        {
            [self.loopBtn setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
            [self.loopBtn setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
        }
            break;
        case XKPlayerPlayStyleRandom:
        {
            [self.loopBtn setImage:[UIImage imageNamed:@"cm2_icn_shuffle"] forState:UIControlStateNormal];
            [self.loopBtn setImage:[UIImage imageNamed:@"cm2_icn_shuffle_prs"] forState:UIControlStateHighlighted];
        }
            break;
        case XKPlayerPlayStyleSingleCycle:
        {
            [self.loopBtn setImage:[UIImage imageNamed:@"cm2_icn_one"] forState:UIControlStateNormal];
            [self.loopBtn setImage:[UIImage imageNamed:@"cm2_icn_one_prs"] forState:UIControlStateHighlighted];
        }
            break;
    }
}

- (void)setCurrentTime:(NSString *)currentTime {
    _currentTime = currentTime;
    self.currentLabel.text = currentTime;
}

- (void)setTotalTime:(NSString *)totalTime {
    _totalTime = totalTime;
    self.totalLabel.text = totalTime;
}

- (void)setBufferValue:(float)bufferValue {
    _bufferValue = bufferValue;
    self.slider.bufferValue = bufferValue;
}

- (void)setValue:(float)value {
    _value = value;
    self.slider.value = value;
}

- (void)setIs_love:(BOOL)is_love {
    _is_love = is_love;
    if (is_love) {
        [self setupLovedBtn];
    }else {
        [self setupLoveBtn];
    }
}

- (void)setupInitialData {
    self.value = 0;
    self.currentTime = @"00:00";
    self.totalTime = @"00:00";
    self.bufferValue = 0;
}

- (void)showLoadingAnim {
    [self.slider showLoading];
}

- (void)hideLoadingAnim {
    [self.slider hideLoading];
}

- (void)setupPlayBtn {
    [self.playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_play"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_play_prs"] forState:UIControlStateHighlighted];
    self.playBtn.selected = YES;
}

- (void)setupPauseBtn {
    [self.playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause_prs"] forState:UIControlStateHighlighted];
    self.playBtn.selected = NO;
}

- (void)setupLoveBtn {
    [self.loveBtn setImage:[UIImage imageNamed:@"cm2_play_icn_love"] forState:UIControlStateNormal];
    [self.loveBtn setImage:[UIImage imageNamed:@"cm2_play_icn_love_prs"] forState:UIControlStateHighlighted];
}

- (void)setupLovedBtn {
    [self.loveBtn setImage:[UIImage imageNamed:@"cm2_play_icn_loved"] forState:UIControlStateNormal];
    [self.loveBtn setImage:[UIImage imageNamed:@"cm2_play_icn_loved_prs"] forState:UIControlStateHighlighted];
}

#pragma mark - UserAction
- (void)loveBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickLove:)]) {
        [self.delegate controlView:self didClickLove:sender];
    }
}

- (void)downloadBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickDownload:)]) {
        [self.delegate controlView:self didClickDownload:sender];
    }
}

- (void)commentBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickComment:)]) {
        [self.delegate controlView:self didClickComment:sender];
    }
}

- (void)moreBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickMore:)]) {
        [self.delegate controlView:self didClickMore:sender];
    }
}

- (void)playBtnClick:(id)sender {
    self.playBtn.selected = !self.playBtn.selected;
    if (self.playBtn.selected) {
        [self setupPlayBtn];
    } else {
        [self setupPauseBtn];
    }
    if ([self.delegate respondsToSelector:@selector(controlView:didClickPlay:)]) {
        [self.delegate controlView:self didClickPlay:sender];
    }
}

- (void)loopBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickLoop:)]) {
        [self.delegate controlView:self didClickLoop:sender];
    }
}

- (void)prevBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickPrev:)]) {
        [self.delegate controlView:self didClickPrev:sender];
    }
}

- (void)nextBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickNext:)]) {
        [self.delegate controlView:self didClickNext:sender];
    }
}

- (void)listBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(controlView:didClickList:)]) {
        [self.delegate controlView:self didClickList:sender];
    }
}

#pragma mark - GKSliderViewDelegate
- (void)sliderTouchBegin:(float)value {
    if ([self.delegate respondsToSelector:@selector(controlView:didSliderTouchBegan:)]) {
        [self.delegate controlView:self didSliderTouchBegan:value];
    }
}

- (void)sliderTouchEnded:(float)value {
    if ([self.delegate respondsToSelector:@selector(controlView:didSliderTouchEnded:)]) {
        [self.delegate controlView:self didSliderTouchEnded:value];
    }
}

- (void)sliderTapped:(float)value {
    if ([self.delegate respondsToSelector:@selector(controlView:didSliderTapped:)]) {
        [self.delegate controlView:self didSliderTapped:value];
    }
}

- (void)sliderValueChanged:(float)value {
    if ([self.delegate respondsToSelector:@selector(controlView:didSliderValueChange:)]) {
        [self.delegate controlView:self didSliderValueChange:value];
    }
}

#pragma mark - 懒加载
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (QMUIButton *)loveBtn {
    if (!_loveBtn) {
        _loveBtn = [[QMUIButton alloc] init];
        [_loveBtn setImage:[UIImage imageNamed:@"cm2_play_icn_love"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"cm2_play_icn_love_prs"] forState:UIControlStateHighlighted];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}

- (QMUIButton *)downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [[QMUIButton alloc] init];
        [_downloadBtn setImage:[UIImage imageNamed:@"cm2_icn_dld"] forState:UIControlStateNormal];
        [_downloadBtn setImage:[UIImage imageNamed:@"cm2_icn_dld_prs"] forState:UIControlStateHighlighted];
        [_downloadBtn addTarget:self action:@selector(downloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

- (QMUIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[QMUIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_cmt"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_cmt_prs"] forState:UIControlStateHighlighted];
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (QMUIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[QMUIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"cm2_play_icn_more"] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"cm2_play_icn_more_prs"] forState:UIControlStateHighlighted];
        [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (QMUIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [[QMUIButton alloc] init];
        [_playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause_prs"] forState:UIControlStateHighlighted];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (QMUIButton *)loopBtn {
    if (!_loopBtn) {
        _loopBtn = [[QMUIButton alloc] init];
        [_loopBtn setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
        [_loopBtn setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
        [_loopBtn addTarget:self action:@selector(loopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loopBtn;
}

- (QMUIButton *)prevBtn {
    if (!_prevBtn) {
        _prevBtn = [[QMUIButton alloc] init];
        [_prevBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_previous"] forState:UIControlStateNormal];
        [_prevBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_previous_prs"] forState:UIControlStateHighlighted];
        [_prevBtn addTarget:self action:@selector(prevBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _prevBtn;
}

- (QMUIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[QMUIButton alloc] init];
        [_nextBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_next"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateHighlighted];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (QMUIButton *)listBtn {
    if (!_listBtn) {
        _listBtn = [[QMUIButton alloc] init];
        [_listBtn setImage:[UIImage imageNamed:@"cm2_icn_list"] forState:UIControlStateNormal];
        [_listBtn setImage:[UIImage imageNamed:@"cm2_icn_list_prs"] forState:UIControlStateHighlighted];
        [_listBtn addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listBtn;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = [UIColor clearColor];
    }
    return _sliderView;
}

- (QMUILabel *)currentLabel {
    if (!_currentLabel) {
        _currentLabel = [[QMUILabel alloc] init];
        _currentLabel.textColor = [UIColor whiteColor];
        _currentLabel.font = [UIFont systemFontOfSize:14.0];
        _currentLabel.text = @"00:00";
    }
    return _currentLabel;
}

- (QMUILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[QMUILabel alloc] init];
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.font = [UIFont systemFontOfSize:14.0];
        _totalLabel.text = @"00:00";
    }
    return _totalLabel;
}

- (XKSliderView *)slider {
    if (!_slider) {
        _slider = [[XKSliderView alloc] init];
        [_slider setBackgroundImage:[UIImage imageNamed:@"cm2_fm_playbar_btn"] forState:UIControlStateNormal];
        [_slider setBackgroundImage:[UIImage imageNamed:@"cm2_fm_playbar_btn"] forState:UIControlStateSelected];
        [_slider setBackgroundImage:[UIImage imageNamed:@"cm2_fm_playbar_btn"] forState:UIControlStateHighlighted];
        
        [_slider setThumbImage:[UIImage imageNamed:@"cm2_fm_playbar_btn_dot"] forState:UIControlStateNormal];
        [_slider setThumbImage:[UIImage imageNamed:@"cm2_fm_playbar_btn_dot"] forState:UIControlStateSelected];
        [_slider setThumbImage:[UIImage imageNamed:@"cm2_fm_playbar_btn_dot"] forState:UIControlStateHighlighted];
        _slider.maximumTrackImage = [UIImage imageNamed:@"cm2_fm_playbar_bg"];
        _slider.minimumTrackImage = [UIImage imageNamed:@"cm2_fm_playbar_curr"];
        _slider.bufferTrackImage  = [UIImage imageNamed:@"cm2_fm_playbar_ready"];
        _slider.delegate = self;
        _slider.sliderHeight = 2;
    }
    return _slider;
}

@end
