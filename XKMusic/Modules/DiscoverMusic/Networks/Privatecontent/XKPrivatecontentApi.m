//
//  XKPrivatecontentApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPrivatecontentApi.h"

@implementation XKPrivatecontentApi

- (NSString *)requestUrl {
    return @"/personalized/privatecontent";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
