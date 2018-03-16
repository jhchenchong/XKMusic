//
//  XKPersonalizedApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPersonalizedApi.h"

@implementation XKPersonalizedApi

- (NSString *)requestUrl {
    return @"/personalized";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
