//
//  XKToolsMacro.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#ifndef XKToolsMacro_h
#define XKToolsMacro_h

#define XKWEAK  @weakify(self);
#define XKSTRONG @strongify(self);

#define XKBLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

#define iPhoneX_BOTTOM_HEIGHT  ([UIScreen mainScreen].bounds.size.height==812?34:0)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define keyWindow [UIApplication sharedApplication].keyWindow

#define XKPlayerVC [XKPlayerController sharedInstance]

#define KAUTOSCALE(num) ((SCREEN_WIDTH/375)*num)

#define MUSICURL(musicID) [NSString stringWithFormat:@"http://music.163.com/song/media/outer/url?id=%@.mp3", musicID]

#endif
