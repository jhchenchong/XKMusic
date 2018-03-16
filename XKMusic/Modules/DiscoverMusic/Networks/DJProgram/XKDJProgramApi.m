//
//  XKDJProgramApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/15.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDJProgramApi.h"

@implementation XKDJProgramApi

- (NSString *)requestUrl {
    return @"/personalized/djprogram";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


@end
