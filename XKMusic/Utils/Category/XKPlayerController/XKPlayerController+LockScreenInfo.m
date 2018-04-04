//
//  XKPlayerController+LockScreenInfo.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/4.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKPlayerController+LockScreenInfo.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation XKPlayerController (LockScreenInfo)

- (void)createRemoteCommandCenter {
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self pauseMusic];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self playMusic];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    [commandCenter.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self playPrevMusic];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [commandCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [self playNextMusic];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
//    if (@available(iOS 9.1, *)) {
//        [commandCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//            MPChangePlaybackPositionCommandEvent *playbackPositionEvent = (MPChangePlaybackPositionCommandEvent *)event;
////            playbackPositionEvent.positionTime
//            
////            [self.player seekToTime:CMTimeMake(totlaTime.value*playbackPositionEvent.positionTime/CMTimeGetSeconds(totlaTime), totlaTime.timescale) completionHandler:^(BOOL finished) {
////            }];
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];
//    } else {
//        
//    }
}

- (void)showLockScreenMediaInfoWithMusicModel:(XKMusicModel *)model totalTime:(CGFloat)totalTime currentTime:(CGFloat)currentTime lyric:(NSString *)lyric image:(UIImage *)image {
    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
    [songDict setObject:model.music_name forKey:MPMediaItemPropertyTitle];
    [songDict setObject:model.music_artist forKey:MPMediaItemPropertyArtist];
    [songDict setObject:lyric forKey:MPMediaItemPropertyAlbumTitle];
    [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
    [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    if (image) {
        [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:image]
                     forKey:MPMediaItemPropertyArtwork];
    }
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
}

- (void)showDefaultLockScreenMediaInfoWithMusicModel:(XKMusicModel *)model totalTime:(CGFloat)totalTime currentTime:(CGFloat)currentTime image:(UIImage *)image {
    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
    [songDict setObject:model.music_name forKey:MPMediaItemPropertyTitle];
    [songDict setObject:model.music_artist forKey:MPMediaItemPropertyArtist];
    [songDict setObject:model.music_name forKey:MPMediaItemPropertyAlbumTitle];
    [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
    [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    if (image) {
        [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:image]
                     forKey:MPMediaItemPropertyArtwork];
    }
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
}
@end
