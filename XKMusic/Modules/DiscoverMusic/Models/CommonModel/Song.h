//
//  Song.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"
#import "Artist.h"
#import "Privilege.h"
#import "Music.h"

@interface Song : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy) NSArray<NSString *> *alias;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger fee;
@property (nonatomic, assign) NSInteger copyrightID;
@property (nonatomic, copy) NSString *disc;
@property (nonatomic, assign) NSInteger no;
@property (nonatomic, copy) NSArray<Artist *> *artists;
@property (nonatomic, strong) Album *album;
@property (nonatomic, assign) BOOL isStarred;
@property (nonatomic, assign) NSInteger popularity;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger starredNum;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger playedNum;
@property (nonatomic, assign) NSInteger dayPlays;
@property (nonatomic, assign) NSInteger hearTime;
@property (nonatomic, copy) NSString *ringtone;
@property (nonatomic, copy) NSString *crbt;
@property (nonatomic, copy) NSString *audition;
@property (nonatomic, copy) NSString *theCopyFrom;
@property (nonatomic, copy) NSString *commentThreadID;
@property (nonatomic, copy) NSString *rtURL;
@property (nonatomic, assign) NSInteger ftype;
@property (nonatomic, copy) NSArray *rtUrls;
@property (nonatomic, assign) NSInteger copyright;
@property (nonatomic, strong) Music *hMusic;
@property (nonatomic, strong) Music *mMusic;
@property (nonatomic, strong) Music *lMusic;
@property (nonatomic, strong) Music *bMusic;
@property (nonatomic, assign) NSInteger mvid;
@property (nonatomic, assign) NSInteger rtype;
@property (nonatomic, copy) NSString *rurl;
@property (nonatomic, copy) NSString *mp3URL;
@property (nonatomic, strong) Privilege *privilege;

@end
