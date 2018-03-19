//
//  XKLoginModel.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account :NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger viptypeVersion;
@property (nonatomic, assign) NSInteger whitelistAuthority;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, copy) NSString *salt;
@property (nonatomic, assign) NSInteger ban;
@property (nonatomic, assign) NSInteger tokenVersion;
@property (nonatomic, assign) NSInteger donateVersion;
@property (nonatomic, assign) NSInteger baoyueVersion;
@property (nonatomic, assign) NSInteger vipType;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL anonimousUser;

@end

@interface Bindings :NSObject

@property (nonatomic, assign) BOOL expired;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *tokenJsonStr;
@property (nonatomic, assign) NSInteger refreshTime;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, copy) NSString *url;

@end

@interface Experts :NSObject

@end

@interface Profile :NSObject

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger authority;
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) BOOL mutual;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger accountStatus;
@property (nonatomic, assign) BOOL followed;
@property (nonatomic, copy) NSString *avatarImgIdStr;
@property (nonatomic, assign) NSInteger authStatus;
@property (nonatomic, copy) NSString *backgroundUrl;
@property (nonatomic, assign) BOOL defaultAvatar;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, assign) NSInteger vipType;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *avatarImgId_str;
@property (nonatomic, assign) NSInteger djStatus;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) Experts *experts;
@property (nonatomic, copy) NSString *backgroundImgIdStr;
@property (nonatomic, copy) NSString *expertTags;
@property (nonatomic, copy) NSString *detailDescription;
@property (nonatomic, assign) NSInteger avatarImgId;
@property (nonatomic, assign) NSInteger backgroundImgId;
@property (nonatomic, copy) NSString *desc;

@end

@interface XKLoginModel : NSObject

@property (nonatomic, strong) Account *account;
@property (nonatomic, copy) NSArray<Bindings *> *bindings;
@property (nonatomic, assign) NSInteger effectTime;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, strong) Profile *profile;
@property (nonatomic, assign) NSInteger loginType;

+ (RACSignal *)signalForLoginWithPhone:(NSString *)phone password:(NSString *)password;

@end
