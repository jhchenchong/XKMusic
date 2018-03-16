//
//  XKBannerApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKBannerApi.h"

@implementation XKBannerApi

- (NSString *)requestUrl {
    return @"/banner";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
