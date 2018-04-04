//
//  XKPlayerController+LockScreenInfo.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/4.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlayerController.h"

@interface XKPlayerController (LockScreenInfo)

- (void)createRemoteCommandCenter;
- (void)showLockScreenMediaInfoWithMusicModel:(XKMusicModel *)model totalTime:(CGFloat)totalTime currentTime:(CGFloat)currentTime lyric:(NSString *)lyric image:(UIImage *)image;
- (void)showDefaultLockScreenMediaInfoWithMusicModel:(XKMusicModel *)model totalTime:(CGFloat)totalTime currentTime:(CGFloat)currentTime image:(UIImage *)image;

@end
