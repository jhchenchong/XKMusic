//
//  Artist.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger picID;
@property (nonatomic, assign) NSInteger img1V1ID;
@property (nonatomic, copy)   NSString *briefDesc;
@property (nonatomic, copy)   NSString *picURL;
@property (nonatomic, copy)   NSString *img1V1URL;
@property (nonatomic, assign) NSInteger albumSize;
@property (nonatomic, copy)   NSArray *alias;
@property (nonatomic, copy)   NSString *trans;
@property (nonatomic, assign) NSInteger musicSize;

@end
