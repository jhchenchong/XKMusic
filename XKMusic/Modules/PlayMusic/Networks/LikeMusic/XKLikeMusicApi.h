//
//  XKLikeMusicApi.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface XKLikeMusicApi : YTKRequest

- (instancetype)initWithMusicID:(NSString *)musicID isLike:(BOOL)isLike;

@end
