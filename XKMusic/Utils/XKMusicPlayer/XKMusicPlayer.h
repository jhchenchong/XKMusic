//
//  XKMusicPlayer.h
//  XKMusicPlayer
//
//  Created by 浪漫恋星空 on 2017/9/18.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, XKMusicPlayerStatus) {
    XKMusicPlayerStatusBuffering,   // 加载中
    XKMusicPlayerStatusPlaying,     // 播放中
    XKMusicPlayerStatusPaused,      // 暂停
    XKMusicPlayerStatusEnded,       // 播放结束
    XKMusicPlayerStatusError        // 播放出错
};

@class XKMusicPlayer;

@protocol XKMusicPlayerDelegate <NSObject>

@optional

- (void)xkMusicPlayer:(XKMusicPlayer *)player statusChanged:(XKMusicPlayerStatus)status;
- (void)xkMusicPlayer:(XKMusicPlayer *)player totalTime:(CGFloat)totalTime currentTime:(NSInteger)currentTime progress:(CGFloat)progress;
- (void)xkMusicPlayer:(XKMusicPlayer *)player cacheProgress:(CGFloat)cacheProgress;
- (void)xkMusicPlayerDidEndPlay:(XKMusicPlayer *)player;

@end

@interface XKMusicPlayer : NSObject

/// 代理
@property (nonatomic, weak) id<XKMusicPlayerDelegate> delegate;
/// 音乐播放地址
@property (nonatomic, copy) NSString *musicUrlString;
/// 播放状态
@property (nonatomic, assign, readonly) XKMusicPlayerStatus status;
/// 播放进度
@property (nonatomic, assign) NSInteger progress;

+ (instancetype)sharedInstance;

- (void)play;
- (void)pause;

@end
