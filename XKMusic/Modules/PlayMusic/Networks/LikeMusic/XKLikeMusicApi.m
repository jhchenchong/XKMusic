//
//  XKLikeMusicApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLikeMusicApi.h"

@interface XKLikeMusicApi ()

@property (nonatomic, copy) NSString *musicID;
@property (nonatomic, assign) BOOL isLike;

@end

@implementation XKLikeMusicApi

- (instancetype)initWithMusicID:(NSString *)musicID isLike:(BOOL)isLike {
    if (self = [super init]) {
        _musicID = musicID;
        _isLike = isLike;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/like";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{@"id": _musicID, @"like":@(_isLike)};
}

@end
