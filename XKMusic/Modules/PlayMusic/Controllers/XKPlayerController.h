//
//  XKPlayerController.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "XKMusicModel.h"

@interface XKPlayerController : QMUICommonViewController

@property (nonatomic, copy) NSString *currentMusicID;
/// 是否正在播放
@property (nonatomic, assign) BOOL isPlaying;

+ (instancetype)sharedInstance;

- (void)setupMusicModels:(NSArray<XKMusicModel *> *)models;
- (void)playMusicWithIndex:(NSInteger)index musicModels:(NSArray<XKMusicModel *> *)models;

@end
