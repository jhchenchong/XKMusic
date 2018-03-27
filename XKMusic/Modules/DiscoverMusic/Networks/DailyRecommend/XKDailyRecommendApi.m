//
//  XKDailyRecommendApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKDailyRecommendApi.h"

@implementation XKDailyRecommendApi

- (NSString *)requestUrl {
    return @"/recommend/songs";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSInteger)cacheTimeInSeconds {
    return 3600;
}

@end
