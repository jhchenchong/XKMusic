//
//  XKSongListInfoModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKSongListInfoModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *creatorname;
@property (nonatomic, copy) NSString *creatorIcon;
@property (nonatomic, assign) NSInteger subscribedCount;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger shareCount;

+ (instancetype)modelWithName:(NSString *)name
                         desc:(NSString *)desc
                    playcount:(NSInteger)playcount
                        cover:(NSString *)cover
                  creatorname:(NSString *)creatorname
                  creatorIcon:(NSString *)creatorIcon
              subscribedCount:(NSInteger)subscribedCount
                 commentCount:(NSInteger)commentCount
                   shareCount:(NSInteger)shareCount;

@end
