//
//  XKDailyRecommendModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface XKDailyRecommendModel :NSObject

@property (nonatomic, assign) NSInteger ftype;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, strong) Music *lMusic;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) Music *bMusic;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger copyright;
@property (nonatomic, assign) NSInteger no;
@property (nonatomic, copy) NSString *audition;
@property (nonatomic, strong) Privilege *privilege;
@property (nonatomic, strong) Music *hMusic;
@property (nonatomic, strong) Album *album;
@property (nonatomic, copy) NSString *ringtone;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, assign) NSInteger rtype;
@property (nonatomic, assign) NSInteger mvid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *rurl;
@property (nonatomic, assign) NSInteger playedNum;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger dayPlays;
@property (nonatomic, assign) NSInteger hearTime;
@property (nonatomic, assign) BOOL starred;
@property (nonatomic, assign) NSInteger fee;
@property (nonatomic, copy) NSString *crbt;
@property (nonatomic, copy) NSString *rtUrl;
@property (nonatomic, copy) NSArray<Artist *> *artists;
@property (nonatomic, assign) CGFloat popularity;
@property (nonatomic, assign) NSInteger copyrightId;
@property (nonatomic, copy) NSString *mp3Url;
@property (nonatomic, strong) Music *mMusic;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, assign) NSInteger starredNum;
@property (nonatomic, copy) NSString *disc;
@property (nonatomic, copy) NSString *alg;

+ (RACSignal *)signalForDailyRecommendModels;

@end

