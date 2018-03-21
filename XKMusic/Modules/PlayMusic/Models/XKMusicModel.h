//
//  XKMusicModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKMusicModel : NSObject

@property (nonatomic, copy) NSString *music_id;
@property (nonatomic, copy) NSString *music_name;
@property (nonatomic, copy) NSString *music_artist;
@property (nonatomic, copy) NSString *music_cover;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isLike;

@end
