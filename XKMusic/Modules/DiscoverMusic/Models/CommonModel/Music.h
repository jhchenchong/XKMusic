//
//  Music.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy)   NSString *extension;
@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger dfsID;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, assign) NSInteger playTime;
@property (nonatomic, assign) NSInteger volumeDelta;

@end
