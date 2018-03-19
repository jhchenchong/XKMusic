//
//  XKLoginApi.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface XKLoginApi : YTKRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password;

@end
