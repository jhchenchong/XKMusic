//
//  XKNewsongApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKNewsongApi.h"

@implementation XKNewsongApi

- (NSString *)requestUrl {
    return @"/personalized/newsong";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
