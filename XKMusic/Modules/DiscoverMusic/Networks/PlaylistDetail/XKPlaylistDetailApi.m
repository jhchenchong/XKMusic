//
//  XKPlaylistDetailApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlaylistDetailApi.h"

@interface XKPlaylistDetailApi ()

@property (nonatomic, copy) NSString *ID;

@end

@implementation XKPlaylistDetailApi

- (instancetype)initWithID:(NSString *)ID {
    if (self = [super init]) {
        _ID = ID;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/playlist/detail";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"id": _ID,
             };
}

@end
