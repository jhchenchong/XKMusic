//
//  XKPlayerController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlayerController.h"
#import "XKMusicControlView.h"
#import "XKMusicPlayer.h"
#import "XKPlayerController+KTVHTTPCache.h"
#import "XKPlayerController+LockScreenInfo.h"
#import "XKLyricModel.h"
#import "XKMusicLyricView.h"
#import "XKLikeMusicApi.h"
#import "XKMusicListView.h"
#import "XKMusicCoverView.h"
#import "XKHelper.h"
#import <UIImageView+WebCache.h>

@interface XKPlayerController ()<XKMusicControlViewDelegate, XKMusicCoverViewDelegate, XKMusicPlayerDelegate>

/// 背景视图
@property (nonatomic, strong) LKImageView *bgImageView;
/// 封面视图
@property (nonatomic, strong) XKMusicCoverView *coverView;
/// 音乐控制视图
@property (nonatomic, strong) XKMusicControlView *controlView;
/// 歌词视图
@property (nonatomic, strong) XKMusicLyricView *lyricView;
/// 音乐列表视图
@property (nonatomic, strong) XKMusicListView *musicListView;
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
/// 是否自动播放
@property (nonatomic, assign) BOOL isAutoPlay;
/// 是否在快进快退
@property (nonatomic, assign) BOOL isSeeking;
/// 是否转盘在滑动
@property (nonatomic, assign) BOOL isCoverScroll;
/// 是否更新音乐控制视图
@property (nonatomic, assign) BOOL isUpdatingControlView;
/// 列表视图是否现在显示
@property (nonatomic, assign) BOOL isExist;
/// 是否正在执行删除操作
@property (nonatomic, assign) BOOL isDelete;
/// 是否回调了第一句歌词
@property (nonatomic, assign) BOOL isFirstLyric;
/// 总时间
@property (nonatomic, assign) NSTimeInterval duration;
/// 当前时间
@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, strong) UIImageView *imageView;

@end

static XKPlayerController *_playerVC = nil;
static dispatch_once_t onceToken;

@implementation XKPlayerController

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        _playerVC = [[XKPlayerController alloc] init];
    });
    return _playerVC;
}

+ (void)destroyInstance {
    _playerVC = nil;
    onceToken = 0l;
}

- (void)dealloc {
    NSLog(@"单例销毁了。。。。");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [XKAppDelegateHelper hideAnimationButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHTTPCache];
    [XKMusicPlayer sharedInstance].delegate = self;
    /// 获取播放模式
    self.playStyle = [[NSUserDefaults standardUserDefaults] integerForKey:kXKPlayStyle];
    self.controlView.style = self.playStyle;
    
    /// 配置消息节流 快速点击 上一曲 下一曲的时候
    MTRule *rule = [[MTRule alloc] initWithTarget:self selector:@selector(playNextMusic) durationThreshold:1];
    rule.mode = MTPerformModeFirstly;
    MTRule *rule1 = [[MTRule alloc] initWithTarget:self selector:@selector(playPrevMusic) durationThreshold:1];
    rule1.mode = MTPerformModeFirstly;
    [MTEngine.defaultEngine applyRule:rule];
    [MTEngine.defaultEngine applyRule:rule1];
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
    [self configRightBarButtonItem];
}

- (void)configRightBarButtonItem {
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"cm2_topbar_icn_share") tintColor:UIColorWhite position:QMUINavigationButtonPositionRight target:self action:@selector(handleRightButtonEvent)];
}

- (void)handleRightButtonEvent {
    QMUIMoreOperationController *moreOperationController = [[QMUIMoreOperationController alloc] init];
    moreOperationController.contentBackgroundColor = moreOperationController.cancelButtonBackgroundColor = UIColorGray;
    moreOperationController.itemTitleColor = moreOperationController.cancelButtonTitleColor = [XKColorHelper textMainColor];
    moreOperationController.items = @[
                                      @[
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_share") title:@"云音乐动态" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_mail") title:@"私信" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }]
                                          ],
                                      @[
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_pyq") title:@"微信朋友圈" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_weixin") title:@"微信好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_qzone") title:@"QQ空间" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_qq") title:@"QQ好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_sina") title:@"微博" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_yxq") title:@"易信朋友圈" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_yixin") title:@"易信好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }],
                                          [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"cm2_blogo_copylink") title:@"复制链接" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                                              [moreOperationController hideToBottom];
                                          }]
                                          ],
                                      ];
    [moreOperationController showFromBottom];
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.lyricView];
    
    /// 布局
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(170);
    }];
    [self.lyricView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(kTopHeight + 10);
        make.bottom.equalTo(self.controlView.mas_top).offset(20);
    }];
}

#pragma mark -- Section
- (void)fetchMusicInfo {
    [[NSUserDefaults standardUserDefaults] setValue:self.model.music_id forKey:kCurrentMusicID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray *likeMusicIDs = (NSArray *)([[NSUserDefaults standardUserDefaults] objectForKey:kLikeMusicIDKey]);
    self.model.isLike = [likeMusicIDs containsObject:self.model.music_id];
    [self.controlView setupInitialData];
    self.titleView.title = self.model.music_name;
    self.titleView.subtitle = self.model.music_artist;
    self.bgImageView.URL = self.model.music_cover;
    self.currentMusicID = self.model.music_id;
    self.controlView.is_love = self.model.isLike;
    NSString *musicUrlString = [KTVHTTPCache proxyURLStringWithOriginalURLString:MUSICURL(self.model.music_id)];
    [XKMusicPlayer sharedInstance].musicUrlString = musicUrlString;
    self.lyricView.lyricModels = nil;
    [self.controlView setupPlayBtn];
    self.isFirstLyric = NO;
    [self fetchLyricInfo];
    [self createRemoteCommandCenter];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.music_cover]];
}

- (void)fetchLyricInfo {
    [[XKLyricModel signalForLyricModelsWithMusicID:self.currentMusicID] subscribeNext:^(NSArray<XKLyricModel *> *x) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.lyricView.lyricModels = x;
        });
    }];
}

#pragma mark -- XKMusicPlayerDelegate
- (void)xkMusicPlayer:(XKMusicPlayer *)player statusChanged:(XKMusicPlayerStatus)status {
    switch (status) {
        case XKMusicPlayerStatusBuffering:
            self.isPlaying = NO;
            [self.controlView showLoadingAnim];
            break;
        case XKMusicPlayerStatusPlaying:
            self.isPlaying = YES;
            [self.controlView hideLoadingAnim];
            [self.coverView playedWithAnimated:YES];
            if (self.isExist == YES) {
                self.musicListView.musicModels = self.musicModels;
                self.musicListView.playStyle = self.playStyle;
            }
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kAnimationButtnStateChanged object:nil];
}
- (void)xkMusicPlayer:(XKMusicPlayer *)player totalTime:(CGFloat)totalTime currentTime:(NSInteger)currentTime progress:(CGFloat)progress {
    if (self.isDraging) return;
    if (self.isSeeking) return;
    /// 拖动进度条改变播放进度时 会出现滑块闪动的情况 最开始怀疑是滑块的在滑动的时候同时响应了滑动和点击事件 最后发现 在改变进度之后 progress第一次回来的值是滑动之前的 不知道是什么原因造成的 这里先用这个属性保护一下
    if (self.isUpdatingControlView == YES) {
        self.controlView.value = progress;
        self.duration = totalTime;
        self.currentTime = currentTime;
        self.controlView.totalTime = [NSString qmui_timeStringWithMinsAndSecsFromSecs:totalTime];
        self.controlView.currentTime = [NSString qmui_timeStringWithMinsAndSecsFromSecs:currentTime];
    }
    if (!self.isFirstLyric) {
        [self showDefaultLockScreenMediaInfoWithMusicModel:self.model totalTime:totalTime currentTime:currentTime image:self.imageView.image];
    }
    self.isUpdatingControlView = YES;
    [self.lyricView scrollLyricWithCurrentTime:currentTime totalTime:totalTime];
}
- (void)xkMusicPlayer:(XKMusicPlayer *)player cacheProgress:(CGFloat)cacheProgress {
    self.controlView.bufferValue = cacheProgress;
}
- (void)xkMusicPlayerDidEndPlay:(XKMusicPlayer *)player {
    self.isAutoPlay = YES;
    [self playNextMusic];
}

#pragma mark -- XKMusicControlViewDelegate
- (void)controlView:(XKMusicControlView *)controlView didClickLove:(UIButton *)loveBtn {
    self.model.isLike = !self.model.isLike;
    self.controlView.is_love = self.model.isLike;
    [[[XKLikeMusicApi alloc] initWithMusicID:self.model.music_id isLike:self.model.isLike] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([request.responseObject[@"code"] integerValue] == 200) {
            if (self.model.isLike) {
                [QMUITips showWithText:@"已添加到我喜欢的音乐"];
                [XKMusicHelper saveLikeMusicID:self.model.music_id];
            } else {
                [QMUITips showWithText:@"已取消喜欢"];
                [XKMusicHelper removeLikeMusicID:self.model.music_id];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)controlView:(XKMusicControlView *)controlView didClickDownload:(UIButton *)downloadBtn {
    [QMUITips showWithText:@"下载"];
}
- (void)controlView:(XKMusicControlView *)controlView didClickComment:(UIButton *)commentBtn {
    [QMUITips showWithText:@"评论"];
}
- (void)controlView:(XKMusicControlView *)controlView didClickMore:(UIButton *)moreBtn {
    [QMUITips showWithText:@"更多"];
}
- (void)controlView:(XKMusicControlView *)controlView didClickLoop:(UIButton *)loopBtn {
    [self handleLoopButtonEvent];
}
- (void)controlView:(XKMusicControlView *)controlView didClickPrev:(UIButton *)prevBtn {
    if (self.isCoverScroll) return;
    [self playPrevMusic];
}
- (void)controlView:(XKMusicControlView *)controlView didClickPlay:(UIButton *)playBtn {
    self.isPlaying ? [self pauseMusic] : [self playMusic];
}
- (void)controlView:(XKMusicControlView *)controlView didClickNext:(UIButton *)nextBtn {
    if (self.isCoverScroll) return;
    self.isAutoPlay = NO;
    [self playNextMusic];
}
- (void)controlView:(XKMusicControlView *)controlView didClickList:(UIButton *)listBtn {
    QMUIModalPresentationViewController *modalPresentationViewController = [[QMUIModalPresentationViewController alloc] init];
    modalPresentationViewController.contentView = self.musicListView;
    self.musicListView.shouldScroll = YES;
    self.musicListView.musicModels = self.musicModels;
    self.musicListView.playStyle = self.playStyle;
    XKWEAK
    self.musicListView.closeButtonBlock = ^{
        XKSTRONG
        self.isExist = NO;
        [modalPresentationViewController hideWithAnimated:YES completion:NULL];
    };
    _musicListView.deleteButtonBlock = ^{
        XKSTRONG
        [XKMusicHelper removeAllMusicModel];
        [[XKMusicPlayer sharedInstance] pause];
        [modalPresentationViewController hideWithAnimated:YES completion:^(BOOL finished) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [XKPlayerController destroyInstance];
        }];
    };
    _musicListView.listDeleteButtonBlock = ^(XKMusicModel *model) {
        XKSTRONG
        self.isDelete = YES;
        if ([model.music_id isEqualToString:self.currentMusicID]) {
            if (self.musicModels.count > 1) {
                __block NSInteger currentIndex = 0;
                [self.musicModels enumerateObjectsUsingBlock:^(XKMusicModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.music_id isEqualToString:self.model.music_id]) {
                        currentIndex = idx;
                        *stop = YES;
                    }
                }];
                /// 如果删除的正在播放的音乐是最后一首 那么就播放上一首 否则 播放下一曲(播放下一曲的时候 不要将currentIndex+1了 因为在移除了当前的之后 下一曲的下标就是当前的下标)
                (currentIndex == self.musicModels.count - 1) ? (currentIndex -= 1) :(currentIndex = currentIndex);
                [XKMusicHelper removeMusicModelWithMusicID:model.music_id];
                [self setupMusicModels:[XKMusicHelper musicModels]];
                [self playMusicWithIndex:currentIndex musicModels:self.musicModels];
            } else {
                [[XKMusicPlayer sharedInstance] pause];
                [modalPresentationViewController hideWithAnimated:YES completion:^(BOOL finished) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [XKPlayerController destroyInstance];
                }];
            }
        } else {
            [XKMusicHelper removeMusicModelWithMusicID:model.music_id];
            [self setupMusicModels:[XKMusicHelper musicModels]];
            self.musicListView.musicModels = self.musicModels;
            self.musicListView.playStyle = self.playStyle;
        }
        self.isDelete = NO;
    };
    modalPresentationViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
    modalPresentationViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        XKSTRONG
        self.musicListView.frame = CGRectMake(0, SCREEN_HEIGHT - 440, SCREEN_WIDTH, 440);
    };
    modalPresentationViewController.didHideByDimmingViewTappedBlock = ^{
        XKSTRONG
        self.isExist = NO;
    };
    [modalPresentationViewController showWithAnimated:YES completion:NULL];
    self.isExist = YES;
}

- (void)controlView:(XKMusicControlView *)controlView didSliderTouchBegan:(float)value {
    self.isDraging = YES;
    self.isUpdatingControlView = NO;
}
- (void)controlView:(XKMusicControlView *)controlView didSliderTouchEnded:(float)value {
    self.isDraging = NO;
    NSInteger time = floorf(self.duration * value);
    [XKMusicPlayer sharedInstance].progress = time;
}
- (void)controlView:(XKMusicControlView *)controlView didSliderValueChange:(float)value {
    self.isDraging = YES;
    self.isUpdatingControlView = NO;
    self.controlView.currentTime = [NSString qmui_timeStringWithMinsAndSecsFromSecs:self.duration * value];
}
- (void)controlView:(XKMusicControlView *)controlView didSliderTapped:(float)value {
    self.isDraging = NO;
    NSInteger time = floorf(self.duration * value);
    [XKMusicPlayer sharedInstance].progress = time;
}

#pragma mark -- XKMusicNewCoverViewDelegate

- (void)scrollDidScroll {
    self.isCoverScroll = YES;
}

- (void)scrollDidChangeModel:(XKMusicModel *)model {
    self.isCoverScroll = NO;
    self.model = model;
    [self fetchMusicInfo];
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
    [XKMusicHelper saveCurrentMusicModels:models];
}

- (void)playMusicWithIndex:(NSInteger)index musicModels:(NSArray<XKMusicModel *> *)models {
    self.playMusicModels = models;
    XKMusicModel *model = models[index];
    if (![model.music_id isEqualToString:self.currentMusicID]) {
        self.model = model;
        [self.coverView setupMusicModels:models index:index];
        [self fetchMusicInfo];
    }
}

- (void)loadMusicWithIndex:(NSInteger)index musicModels:(NSArray<XKMusicModel *> *)models {
    self.playMusicModels = models;
    self.musicModels = models;
    XKMusicModel *model = models[index];
    if (![model.music_id isEqualToString:self.currentMusicID]) {
        self.model = model;
        NSArray *likeMusicIDs = (NSArray *)([[NSUserDefaults standardUserDefaults] objectForKey:kLikeMusicIDKey]);
        self.model.isLike = [likeMusicIDs containsObject:self.model.music_id];
        [self.coverView setupMusicModels:models index:index];
        self.titleView.title = self.model.music_name;
        self.titleView.subtitle = self.model.music_artist;
        self.bgImageView.URL = self.model.music_cover;
        self.controlView.is_love = self.model.isLike;
    }
}

- (void)playMusic {
    if ([XKMusicPlayer sharedInstance].musicUrlString) {
        [[XKMusicPlayer sharedInstance] play];
    } else {
        [self fetchMusicInfo];
    }
}

- (void)pauseMusic {
    [[XKMusicPlayer sharedInstance] pause];
}

- (void)playNextMusic {
    switch (self.playStyle) {
            
        case XKPlayerPlayStyleLoop:
            [self loopPlayWithChangeStyle:XKPlayerChangeStyleNext];
            break;
            
        case XKPlayerPlayStyleSingleCycle:
            [self singleCyclePlayWithChangeStyle:XKPlayerChangeStyleNext];
            break;
            
        case XKPlayerPlayStyleRandom:
            [self randomPlayWithChangeStyle:XKPlayerChangeStyleNext];
            break;
    }
    if (self.isExist == YES) {
        if (self.playStyle == XKPlayerPlayStyleRandom) {
            self.musicListView.shouldScroll = YES;
        } else {
           self.musicListView.shouldScroll = !self.isDelete;
        }
    }
}

- (void)playPrevMusic {
    switch (self.playStyle) {
            
        case XKPlayerPlayStyleLoop:
            [self loopPlayWithChangeStyle:XKPlayerChangeStylePrev];
            break;
            
        case XKPlayerPlayStyleSingleCycle:
            [self singleCyclePlayWithChangeStyle:XKPlayerChangeStylePrev];
            break;
            
        case XKPlayerPlayStyleRandom:
            [self randomPlayWithChangeStyle:XKPlayerChangeStylePrev];
            break;
    }
}

#pragma mark -- 私有方法
- (void)setCoverModels:(NSArray *)models {
    __block NSUInteger currentIndex = 0;
    [models enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:self.model.music_id]) {
            currentIndex = idx;
            *stop = YES;
        }
    }];
    [self.coverView resetMusicModels:models];
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

- (void)playNextMusicWithMusicModels:(NSArray<XKMusicModel *> *)musicModels index:(NSInteger)currentIndex {
    if (currentIndex < musicModels.count - 1) {
        currentIndex ++;
    } else {
        currentIndex = 0;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.coverView scrollChangeIsNext:YES finished:^{
            [self playMusicWithIndex:currentIndex musicModels:musicModels];
        }];
    });
}

- (void)playPrevMusicWithMusicModels:(NSArray<XKMusicModel *> *)musicModels index:(NSInteger)currentIndex {
    if (currentIndex > 0) {
        currentIndex --;
    } else if (currentIndex == 0) {
        currentIndex = self.musicModels.count - 1;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.coverView scrollChangeIsNext:NO finished:^{
            [self playMusicWithIndex:currentIndex musicModels:musicModels];
        }];
    });
}

- (void)loopPlayWithChangeStyle:(XKPlayerChangeStyle)style {
    NSArray <XKMusicModel *> *musicModels = self.musicModels;
    __block NSUInteger currentIndex = 0;
    [musicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:self.model.music_id]) {
            currentIndex = idx;
            *stop = YES;
        }
    }];
    style == XKPlayerChangeStyleNext ? [self playNextMusicWithMusicModels:musicModels index:currentIndex] : [self playPrevMusicWithMusicModels:musicModels index:currentIndex];
}

- (void)singleCyclePlayWithChangeStyle:(XKPlayerChangeStyle)style {
    if (style == XKPlayerChangeStyleNext) {
        if (self.isAutoPlay) {
            NSArray <XKMusicModel *> *musicModels = self.musicModels;
            __block NSUInteger currentIndex = 0;
            [musicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.music_id isEqualToString:self.model.music_id]) {
                    currentIndex = idx;
                    *stop = YES;
                }
            }];
            [self.coverView setupMusicModels:musicModels index:currentIndex];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self fetchMusicInfo];
            });
        } else {
            NSArray <XKMusicModel *> *musicModels = self.musicModels;
            __block NSUInteger currentIndex = 0;
            [musicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.music_id isEqualToString:self.model.music_id]) {
                    currentIndex = idx;
                    *stop = YES;
                }
            }];
            [self playNextMusicWithMusicModels:musicModels index:currentIndex];
        }
    } else {
        NSArray *musicModels = self.musicModels;
        __block NSUInteger currentIndex = 0;
        [musicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.music_id isEqualToString:self.model.music_id]) {
                currentIndex = idx;
                *stop = YES;
            }
        }];
        [self playPrevMusicWithMusicModels:musicModels index:currentIndex];
    }
}

- (void)randomPlayWithChangeStyle:(XKPlayerChangeStyle)style {
    if (!self.outOrderMusicModels) {
        self.outOrderMusicModels = [self randomArray:self.musicModels];
    }
    NSArray *outOrderMusicModels = self.outOrderMusicModels;
    __block NSInteger currentIndex = 0;
    [outOrderMusicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:self.model.music_id]) {
            currentIndex = idx;
            *stop = YES;
        }
    }];
    style == XKPlayerChangeStyleNext ? [self playNextMusicWithMusicModels:outOrderMusicModels index:currentIndex] : [self playPrevMusicWithMusicModels:outOrderMusicModels index:currentIndex];
}

- (void)showCoverView {
    self.coverView.hidden = NO;
    self.controlView.topView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.lyricView.alpha = 0.0;
        self.coverView.alpha = 1.0;
        self.controlView.topView.alpha  = 1.0;
    }completion:^(BOOL finished) {
        self.lyricView.hidden = YES;
        self.coverView.hidden = NO;
        self.controlView.topView.hidden = NO;
    }];
}

- (void)showLyricView {
    self.lyricView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.lyricView.alpha = 1.0;
        self.coverView.alpha = 0.0;
        self.controlView.topView.alpha  = 0.0;
    }completion:^(BOOL finished) {
        self.lyricView.hidden = NO;
        self.coverView.hidden = YES;
        self.controlView.topView.hidden = YES;
    }];
}

- (void)handleLoopButtonEvent {
    NSString *tip = nil;
    if (self.playStyle == XKPlayerPlayStyleLoop) {
        self.playStyle = XKPlayerPlayStyleSingleCycle;
        self.outOrderMusicModels = nil;
        [self setCoverModels:self.musicModels];
        tip = @"单曲循环";
    } else if (self.playStyle == XKPlayerPlayStyleSingleCycle) {
        self.playStyle = XKPlayerPlayStyleRandom;
        self.outOrderMusicModels = [self randomArray:self.musicModels];
        [self setCoverModels:self.outOrderMusicModels];
        tip = @"随机播放";
    } else {
        self.playStyle = XKPlayerPlayStyleLoop;
        self.outOrderMusicModels = nil;
        [self setCoverModels:self.musicModels];
        tip = @"列表循环";
    }
    self.controlView.style = self.playStyle;
    [QMUITips showWithText:tip];
    [[NSUserDefaults standardUserDefaults] setInteger:self.playStyle forKey:kXKPlayStyle];
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
        _coverView = [[XKMusicCoverView alloc] initWithFrame:CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 190)];
        _coverView.delegate = self;
        XKWEAK
        _coverView.didTapCellBlock = ^{
            XKSTRONG
            [self showLyricView];
        };
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

- (XKMusicLyricView *)lyricView {
    if (!_lyricView) {
        _lyricView = [[XKMusicLyricView alloc] init];
        _lyricView.backgroundColor = [UIColor clearColor];
        _lyricView.hidden = YES;
        _lyricView.PlaySelectedLineBlock = ^(NSTimeInterval time) {
            [XKMusicPlayer sharedInstance].progress = time + 1;
        };
        XKWEAK
        _lyricView.DidUpdatedLyricBlock = ^(NSTimeInterval totalTime, NSTimeInterval currentTime, NSString *lyric) {
            XKSTRONG
            self.isFirstLyric = YES;
            if ([XKHelper isShowLockScreenMediaInfo]) {
                [self showLockScreenMediaInfoWithMusicModel:self.model totalTime:totalTime currentTime:currentTime lyric:lyric image:self.imageView.image];
            }
        };
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            XKSTRONG
            [self showCoverView];
        }];
        [_lyricView addGestureRecognizer:tap];
    }
    return _lyricView;
}

- (XKMusicListView *)musicListView {
    if (!_musicListView) {
        _musicListView = [[XKMusicListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 440)];
        _musicListView.backgroundColor = [UIColor whiteColor];
        XKWEAK
        _musicListView.styleButtonBlock = ^{
            XKSTRONG
            [self handleLoopButtonEvent];
            self.musicListView.playStyle = self.playStyle;
        };
        _musicListView.allButtonBlock = ^{
            XKSTRONG
            [QMUITips showWithText:@"收藏全部" inView:self.musicListView hideAfterDelay:1];
        };
        _musicListView.linkButtonBlock = ^{
            XKSTRONG
            [QMUITips showWithText:@"链接" inView:self.musicListView hideAfterDelay:1];
        };
        _musicListView.didSelectRowAtIndexPathBlock = ^(NSIndexPath *indexPath) {
            XKSTRONG
            self.musicListView.shouldScroll = NO;
            [self playMusicWithIndex:indexPath.row musicModels:self.musicModels];
        };
    }
    return _musicListView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
