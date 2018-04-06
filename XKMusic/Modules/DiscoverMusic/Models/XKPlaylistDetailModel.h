//
//  XKPlaylistDetailModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/5.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface Creator :NSObject

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger authority;
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) BOOL mutual;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger accountStatus;
@property (nonatomic, assign) BOOL followed;
@property (nonatomic, copy) NSString *backgroundUrl;
@property (nonatomic, assign) NSInteger authStatus;
@property (nonatomic, assign) BOOL defaultAvatar;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, assign) NSInteger vipType;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, copy) NSString *avatarImgIdStr;
@property (nonatomic, copy) NSString *avatarImgId_str;
@property (nonatomic, assign) NSInteger djStatus;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *experts;
@property (nonatomic, copy) NSString *backgroundImgIdStr;
@property (nonatomic, copy) NSArray<NSString *> *expertTags;
@property (nonatomic, copy) NSString *detailDescription;
@property (nonatomic, assign) NSInteger avatarImgId;
@property (nonatomic, assign) NSInteger backgroundImgId;
@property (nonatomic, assign) NSInteger userId;

@end

@interface Tracks :NSObject

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
@property (nonatomic, copy) NSString *from;
@property (nonatomic, assign) NSInteger starredNum;
@property (nonatomic, copy) NSString *disc;

@end

@interface XKPlaylistDetailModel : NSObject

@property (nonatomic, strong) Creator *creator;
@property (nonatomic, assign) NSInteger totalDuration;
@property (nonatomic, assign) NSInteger specialType;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger subscribedCount;
@property (nonatomic, copy) NSString *coverImgUrl;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger privacy;
@property (nonatomic, assign) BOOL anonimous;
@property (nonatomic, assign) BOOL newImported;
@property (nonatomic, assign) NSInteger adType;
@property (nonatomic, assign) NSInteger trackNumberUpdateTime;
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) BOOL ordered;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger shareCount;
@property (nonatomic, assign) NSInteger trackUpdateTime;
@property (nonatomic, assign) BOOL subscribed;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL highQuality;
@property (nonatomic, assign) NSInteger cloudTrackCount;
@property (nonatomic, assign) NSInteger coverImgId;
@property (nonatomic, copy) NSArray<NSString *> *tags;
@property (nonatomic, copy) NSString *artists;
@property (nonatomic, copy) NSArray<Tracks *> *tracks;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger trackCount;
@property (nonatomic, copy) NSString *coverImgId_str;
@property (nonatomic, assign) NSInteger userId;

+ (RACSignal *)signalForPlaylistDetailModelWithID:(NSString *)ID;

@end
