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
#import "XKMusicPlayer.h"

@interface XKPlayerController ()<XKMusicControlViewDelegate, XKMusicCoverViewDelegate, XKMusicPlayerDelegate>

/// 背景视图
@property (nonatomic, strong) LKImageView *bgImageView;
/// 封面视图
@property (nonatomic, strong) XKMusicCoverView *coverView;
/// 音乐控制视图
@property (nonatomic, strong) XKMusicControlView *controlView;
/// 音乐模型数组
@property (nonatomic, copy) NSArray<XKMusicModel *> *musicModels;
/// 当前播放的音乐模型数组
@property (nonatomic, copy) NSArray<XKMusicModel *> *playMusicModels;
/// 乱序后的音乐模型数组
@property (nonatomic, copy) NSArray<XKMusicModel *> *outOrderMusicModels;
/// 当前播放的音乐模型
@property (nonatomic, strong) XKMusicModel *model;
/// 播放类型
@property (nonatomic, assign) XKPlayerPlayStyle playStyle;
/// 是否正在拖拽
@property (nonatomic, assign) BOOL isDraging;
/// 是否在快进快退
@property (nonatomic, assign) BOOL isSeeking;
/// 总时间
@property (nonatomic, assign) NSTimeInterval duration;
/// 当前时间
@property (nonatomic, assign) NSTimeInterval currentTime;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [XKMusicPlayer sharedInstance].delegate = self;
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
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.controlView];
    
    /// 布局
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
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

#pragma mark -- Section
- (void)fetchMusicInfo {
    [self.controlView setupInitialData];
    self.titleView.title = self.model.music_name;
    self.titleView.subtitle = self.model.music_artist;
    self.bgImageView.URL = self.model.music_cover;
    [XKMusicPlayer sharedInstance].musicUrlString = MUSICURL(self.model.music_id);
}

#pragma mark -- XKMusicPlayerDelegate
- (void)xkMusicPlayer:(XKMusicPlayer *)player statusChanged:(XKMusicPlayerStatus)status {
    switch (status) {
        case XKMusicPlayerStatusBuffering:
        case XKMusicPlayerStatusPlaying:
            self.isPlaying = YES;
            [self.coverView playedWithAnimated:YES];
            break;
            
        case XKMusicPlayerStatusPaused:
            self.isPlaying = NO;
            [self.coverView pausedWithAnimated:YES];
            break;
            
        case XKMusicPlayerStatusEnded:
            self.isPlaying = NO;
            [self.coverView pausedWithAnimated:YES];
            break;
            
        case XKMusicPlayerStatusError:
            self.isPlaying = NO;
            [self.coverView pausedWithAnimated:YES];
            break;
    }
}
- (void)xkMusicPlayer:(XKMusicPlayer *)player totalTime:(CGFloat)totalTime currentTime:(NSInteger)currentTime progress:(CGFloat)progress {
    if (self.isDraging) return;
    if (self.isSeeking) return;
    self.duration = totalTime;
    self.currentTime = currentTime;
    self.controlView.totalTime = [NSString qmui_timeStringWithMinsAndSecsFromSecs:totalTime];
    self.controlView.currentTime = [NSString qmui_timeStringWithMinsAndSecsFromSecs:currentTime];
    self.controlView.value = progress;
}
- (void)xkMusicPlayer:(XKMusicPlayer *)player cacheProgress:(CGFloat)cacheProgress {
    self.controlView.bufferValue = cacheProgress;
}
- (void)xkMusicPlayerDidEndPlay:(XKMusicPlayer *)player {
    NSLog(@"播放结束");
}

#pragma mark -- XKMusicControlViewDelegate
- (void)controlView:(XKMusicControlView *)controlView didClickLove:(UIButton *)loveBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickDownload:(UIButton *)downloadBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickComment:(UIButton *)commentBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickMore:(UIButton *)moreBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickLoop:(UIButton *)loopBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickPrev:(UIButton *)prevBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickPlay:(UIButton *)playBtn {
    self.isPlaying ? [[XKMusicPlayer sharedInstance] pause] : [[XKMusicPlayer sharedInstance] play];
}
- (void)controlView:(XKMusicControlView *)controlView didClickNext:(UIButton *)nextBtn {
    
}
- (void)controlView:(XKMusicControlView *)controlView didClickList:(UIButton *)listBtn {
    
}

- (void)controlView:(XKMusicControlView *)controlView didSliderTouchBegan:(float)value {
    self.isDraging = YES;
}
- (void)controlView:(XKMusicControlView *)controlView didSliderTouchEnded:(float)value {
    self.isDraging = NO;
    NSInteger time = floorf(self.duration * value);
    [XKMusicPlayer sharedInstance].progress = time;
}
- (void)controlView:(XKMusicControlView *)controlView didSliderValueChange:(float)value {
    self.isDraging = YES;
    self.controlView.currentTime = [NSString qmui_timeStringWithMinsAndSecsFromSecs:self.duration * value];
}
- (void)controlView:(XKMusicControlView *)controlView didSliderTapped:(float)value {
    
}

#pragma mark -- XKMusicCoverViewDelegate

- (void)scrollDidScroll {
    
}

- (void)scrollDidChangeModel:(XKMusicModel *)model {
    self.model = model;
    [self fetchMusicInfo];
}

- (void)scrollDidEnd:(UIScrollView *)scrollView {
    if (self.isPlaying) {
        [self.coverView playedWithAnimated:YES];
    }
}

#pragma mark -- 公共方法
- (void)setupMusicModels:(NSArray<XKMusicModel *> *)models {
    self.musicModels = models;
    if (self.playStyle == XKPlayerPlayStyleRandom) {
        self.outOrderMusicModels = [self randomArray:models];
        [self setCoverModels:self.outOrderMusicModels];
    } else {
        self.outOrderMusicModels = nil;
        [self setCoverModels:models];
    }
}

- (void)playMusicWithIndex:(NSInteger)index musicModels:(NSArray<XKMusicModel *> *)models {
    self.playMusicModels = models;
    XKMusicModel *model = models[index];
    if ([model.music_id isEqualToString:self.currentMusicID]) {
        NSLog(@"歌曲就是当前正在播放的 先不要管");
    } else {
        [self.coverView pausedWithAnimated:YES];
        self.model = model;
        self.currentMusicID = model.music_id;
        [self.coverView setupMusicList:models index:index];
        [self fetchMusicInfo];
    }
}

- (void)setCoverModels:(NSArray *)models {
    __block NSUInteger currentIndex = 0;
    [models enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:self.model.music_id]) {
            currentIndex = idx;
            *stop = YES;
        }
    }];
    [self.coverView resetMusicList:models index:currentIndex];
}

- (NSArray *)randomArray:(NSArray *)arr {
    NSArray *randomArr = [arr sortedArrayUsingComparator:^NSComparisonResult(XKMusicModel *obj1, XKMusicModel *obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1.music_id compare:obj2.music_id];
        } else {
            return [obj2.music_id compare:obj1.music_id];
        }
    }];
    return randomArr;
}

#pragma mark -- 懒加载

- (LKImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[LKImageView alloc] init];
        _bgImageView.defaultImage = UIImageMake(@"cm2_fm_bg-ip6");
        _bgImageView.effect.blurEnabled = YES;
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.frame = self.view.bounds;
        [_bgImageView addSubview:effectView];
    }
    return _bgImageView;
}

- (XKMusicCoverView *)coverView {
    if (!_coverView) {
        _coverView = [[XKMusicCoverView alloc] init];;
        _coverView.delegate = self;
    }
    return _coverView;
}

- (XKMusicControlView *)controlView {
    if (!_controlView) {
        _controlView = [[XKMusicControlView alloc] init];
        _controlView.delegate = self;
    }
    return _controlView;
}

@end
