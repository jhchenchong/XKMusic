//
//  XKSongListInfoModel.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSongListInfoModel.h"

@implementation XKSongListInfoModel

+ (instancetype)modelWithName:(NSString *)name
                         desc:(NSString *)desc
                    playcount:(NSInteger)playcount
                        cover:(NSString *)cover
                  creatorname:(NSString *)creatorname
                  creatorIcon:(NSString *)creatorIcon
              subscribedCount:(NSInteger)subscribedCount
                 commentCount:(NSInteger)commentCount
                   shareCount:(NSInteger)shareCount {
    XKSongListInfoModel *model = [[XKSongListInfoModel alloc] init];
    model.name = name;
    model.desc = desc;
    model.playcount = playcount;
    model.cover = cover;
    model.creatorname = creatorname;
    model.creatorIcon = creatorIcon;
    model.subscribedCount = subscribedCount;
    model.commentCount = commentCount;
    model.shareCount = shareCount;
    return model;
}

@end
