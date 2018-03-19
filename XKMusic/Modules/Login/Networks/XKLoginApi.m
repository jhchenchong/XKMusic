//
//  XKLoginApi.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKLoginApi.h"

@interface XKLoginApi ()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

@end

@implementation XKLoginApi

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password {
    if (self = [super init]) {
        _phone = phone;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/login/cellphone";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"phone": _phone,
             @"password": _password
             };
}

@end
