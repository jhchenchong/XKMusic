//
//  XKPlaylistDetailApi.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface XKPlaylistDetailApi : YTKRequest

- (instancetype)initWithID:(NSString *)ID;

@end
