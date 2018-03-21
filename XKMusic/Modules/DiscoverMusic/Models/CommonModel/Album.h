//
//  Album.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"

@interface Album : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger picID;
@property (nonatomic, copy) NSString *blurPicUrl;
@property (nonatomic, assign) NSInteger companyID;
@property (nonatomic, assign) NSInteger pic;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger publishTime;
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, strong) Artist *artist;
@property (nonatomic, copy) NSArray *songs;
@property (nonatomic, copy) NSArray<NSString *> *alias;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger copyrightID;
@property (nonatomic, copy) NSString *commentThreadID;
@property (nonatomic, copy) NSArray<Artist *> *artists;
@property (nonatomic, copy) NSString *subType;
@property (nonatomic, copy) NSString *picIDStr;

@end
