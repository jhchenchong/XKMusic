//
//  XKDisMusicSongListRecommendedComponent.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKCollectionComponent.h"
#import "XKPersonalizedModel.h"

/// 推荐歌单
@interface XKDisMusicSongListRecommendedComponent : XKCollectionComponent

@property (nonatomic, copy, readonly) NSArray<XKPersonalizedModel *> *models;

@end
