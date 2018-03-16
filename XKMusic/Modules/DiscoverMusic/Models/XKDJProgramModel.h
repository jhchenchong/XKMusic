//
//  XKDJProgramModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/15.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dj :NSObject

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
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, assign) NSInteger djStatus;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *experts;
@property (nonatomic, copy) NSString *backgroundImgIdStr;
@property (nonatomic, copy) NSString *expertTags;
@property (nonatomic, copy) NSString *detailDescription;
@property (nonatomic, assign) NSInteger avatarImgId;
@property (nonatomic, assign) NSInteger backgroundImgId;
@property (nonatomic, assign) NSInteger userId;

@end

@interface H5Links :NSObject

@end

@interface DJAlias :NSObject

@end

@interface LMusic :NSObject

@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger dfsId;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) CGFloat volumeDelta;
@property (nonatomic, copy) NSString *extension;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playTime;

@end

@interface BMusic :NSObject

@property (nonatomic, assign) NSInteger sr;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger dfsId;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) CGFloat volumeDelta;
@property (nonatomic, copy) NSString *extension;
@property (nonatomic, assign) NSInteger bitrate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger playTime;

@end

@interface RtUrls :NSObject

@end

@interface DJSongs :NSObject

@end

@interface DJArtist :NSObject

@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *img1v1Url;
@property (nonatomic, assign) NSInteger albumSize;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, copy) NSArray<DJAlias *> *alias;
@property (nonatomic, assign) NSInteger musicSize;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *trans;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger img1v1Id;

@end

@interface DJArtists :NSObject

@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *img1v1Url;
@property (nonatomic, assign) NSInteger albumSize;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, copy) NSArray<DJAlias *> *alias;
@property (nonatomic, assign) NSInteger musicSize;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *trans;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger img1v1Id;

@end

@interface DJAlbum :NSObject

@property (nonatomic, assign) NSInteger copyrightId;
@property (nonatomic, copy) NSString *subType;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSArray<DJSongs *> *songs;
@property (nonatomic, assign) NSInteger companyId;
@property (nonatomic, copy) NSArray<DJAlias *> *alias;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger pic;
@property (nonatomic, copy) NSString *blurPicUrl;
@property (nonatomic, strong) DJArtist *artist;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, assign) NSInteger publishTime;
@property (nonatomic, copy) NSString *briefDesc;
@property (nonatomic, copy) NSString *picId_str;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSArray<DJArtists *> *artists;
@property (nonatomic, copy) NSString *desc;

@end

@interface MainSong :NSObject

@property (nonatomic, copy) NSArray<DJAlias *> *alias;
@property (nonatomic, assign) NSInteger ftype;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, strong) LMusic *lMusic;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) BMusic *bMusic;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger copyright;
@property (nonatomic, assign) NSInteger no;
@property (nonatomic, copy) NSArray<RtUrls *> *rtUrls;
@property (nonatomic, copy) NSString *audition;
@property (nonatomic, copy) NSString *hMusic;
@property (nonatomic, strong) DJAlbum *album;
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
@property (nonatomic, copy) NSArray<DJArtists *> *artists;
@property (nonatomic, assign) CGFloat popularity;
@property (nonatomic, assign) NSInteger copyrightId;
@property (nonatomic, copy) NSString *mp3Url;
@property (nonatomic, copy) NSString *mMusic;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, assign) NSInteger starredNum;
@property (nonatomic, copy) NSString *disc;

@end

@interface Radio :NSObject

@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, copy) NSString *rcmdText;
@property (nonatomic, assign) BOOL composeVideo;
@property (nonatomic, assign) NSInteger radioFeeType;
@property (nonatomic, assign) NSInteger feeScope;
@property (nonatomic, assign) BOOL underShelf;
@property (nonatomic, assign) NSInteger originalPrice;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger lastProgramCreateTime;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) NSInteger programCount;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger subCount;
@property (nonatomic, assign) NSInteger purchaseCount;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *dj;
@property (nonatomic, assign) NSInteger lastProgramId;
@property (nonatomic, assign) BOOL subed;
@property (nonatomic, copy) NSString *lastProgramName;
@property (nonatomic, assign) BOOL buyed;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *videos;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *discountPrice;

@end

@interface Channels :NSObject

@end

@interface Program :NSObject

@property (nonatomic, strong) Dj *dj;
@property (nonatomic, assign) BOOL buyed;
@property (nonatomic, assign) BOOL publish;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger mainTrackId;
@property (nonatomic, copy) NSString *commentThreadId;
@property (nonatomic, copy) NSArray<H5Links *> *h5Links;
@property (nonatomic, assign) NSInteger subscribedCount;
@property (nonatomic, assign) BOOL reward;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger bdAuditStatus;
@property (nonatomic, copy) NSString *blurCoverUrl;
@property (nonatomic, assign) CGFloat adjustedPlayCount;
@property (nonatomic, assign) NSInteger pubStatus;
@property (nonatomic, copy) NSString *titbits;
@property (nonatomic, assign) NSInteger serialNum;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger shareCount;
@property (nonatomic, assign) NSInteger auditStatus;
@property (nonatomic, assign) BOOL canReward;
@property (nonatomic, assign) BOOL subscribed;
@property (nonatomic, assign) NSInteger listenerCount;
@property (nonatomic, copy) NSString * coverUrl;
@property (nonatomic, assign) NSInteger programFeeType;
@property (nonatomic, strong) MainSong *mainSong;
@property (nonatomic, copy) NSString *songs;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger coverId;
@property (nonatomic, strong) Radio *radio;
@property (nonatomic, assign) NSInteger likedCount;
@property (nonatomic, copy) NSString *programDesc;
@property (nonatomic, assign) NSInteger trackCount;
@property (nonatomic, copy) NSArray<Channels *> *channels;
@property (nonatomic, assign) BOOL isPublish;
@property (nonatomic, copy) NSString *titbitImages;
@property (nonatomic, assign) NSInteger userId;

@end

@interface XKDJProgramModel : NSObject

@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *copywriter;
@property (nonatomic, copy) NSString *alg;
@property (nonatomic, strong) Program *program;
@property (nonatomic, assign) BOOL canDislike;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *name;

+ (RACSignal *)signalForDJProgramModels;

@end
