//
//  XKMusicTool.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKMusicHelper.h"

#define kDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"audio.json"]

@implementation XKMusicHelper

+ (void)saveCurrentMusicModels:(NSArray<XKMusicModel *> *)musicModels {
    [NSKeyedArchiver archiveRootObject:musicModels toFile:kDataPath];
}

+ (NSArray<XKMusicModel *> *)musicModels {
    NSArray<XKMusicModel *> *musicModel = [NSKeyedUnarchiver unarchiveObjectWithFile:kDataPath];
    return musicModel;
}

+ (void)removeMusicModelWithMusicID:(NSString *)musicID {
    NSMutableArray<XKMusicModel *> *musicModels = [self musicModels].mutableCopy;
    [musicModels enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:musicID]) {
            [musicModels removeObject:obj];
            *stop = YES;
        }
    }];
    [self saveCurrentMusicModels:musicModels.copy];
}

+ (void)removeAllMusicModel {
    [NSKeyedArchiver archiveRootObject:@[] toFile:kDataPath];
}

+ (NSInteger)indexFromMusicID:(NSString *)musicID {
    __block NSInteger index = 0;
    [[self musicModels] enumerateObjectsUsingBlock:^(XKMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:musicID]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

+ (void)saveLikeMusicID:(NSString *)musicID {
    NSArray *musicIDs = [[NSUserDefaults standardUserDefaults] objectForKey:kLikeMusicIDKey];
    NSMutableArray *mutableArray = @[].mutableCopy;
    if (musicIDs) {
        mutableArray = musicIDs.mutableCopy;
        if (![mutableArray containsObject:musicID]) {
            [mutableArray addObject:musicID];
        }
    } else {
        [mutableArray addObject:musicID];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray.copy forKey:kLikeMusicIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeLikeMusicID:(NSString *)musicID {
    NSArray *musicIDs = [[NSUserDefaults standardUserDefaults] objectForKey:kLikeMusicIDKey];
    if (!musicIDs) {
        return;
    }
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:musicIDs];
    if ([mutableArray containsObject:musicID]) {
        [mutableArray removeObject:musicID];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray.copy forKey:kLikeMusicIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
