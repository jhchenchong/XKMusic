//
//  XKLyricApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/24.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLyricApi.h"

@interface XKLyricApi ()

@property (nonatomic, copy) NSString *musicID;

@end

@implementation XKLyricApi

- (instancetype)initWithMusicID:(NSString *)musicID {
    if (self = [super init]) {
        _musicID = musicID;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/lyric";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{@"id": _musicID};
}

@end
