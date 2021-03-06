//
//  XKPlayerController.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "XKMusicModel.h"
#import "XKMusicPlayer.h"

@interface XKPlayerController : QMUICommonViewController

@property (nonatomic, copy) NSString *currentMusicID;
/// 是否正在播放
@property (nonatomic, assign) BOOL isPlaying;
/// 当前播放音乐的信息
@property (nonatomic, strong, readonly) XKMusicModel *model;
/// 是否正在拖拽
@property (nonatomic, assign) BOOL isDraging;

+ (instancetype)sharedInstance;
+ (void)destroyInstance;

- (void)setupMusicModels:(NSArray<XKMusicModel *> *)models;
- (void)playMusicWithIndex:(NSInteger)index musicModels:(NSArray<XKMusicModel *> *)models;
- (void)loadMusicWithIndex:(NSInteger)index musicModels:(NSArray<XKMusicModel *> *)models;

- (void)playMusic;
- (void)pauseMusic;
- (void)playNextMusic;
- (void)playPrevMusic;

@end
