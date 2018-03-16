//
//  XKNewsongModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/14.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

@interface Privilege : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger fee;
@property (nonatomic, assign) NSInteger payed;
@property (nonatomic, assign) NSInteger st;
@property (nonatomic, assign) NSInteger pl;
@property (nonatomic, assign) NSInteger dl;
@property (nonatomic, assign) NSInteger sp;
@property (nonatomic, assign) NSInteger cp;
@property (nonatomic, assign) NSInteger subp;
@property (nonatomic, assign) BOOL cs;
@property (nonatomic, assign) NSInteger maxbr;
@property (nonatomic, assign) NSInteger fl;
@property (nonatomic, assign) BOOL isToast;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) BOOL isPreSell;

@end

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

@interface XKNewsongModel : NSObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *copywriter;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) BOOL isCanDislike;
@property (nonatomic, strong) Song *song;
@property (nonatomic, copy) NSString *alg;

+ (RACSignal *)signalForNewsongModels;

@end

NS_ASSUME_NONNULL_END

