//
//  XKMusicPlayer.m
//  XKMusicPlayer
//
//  Created by 浪漫恋星空 on 2017/9/18.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKMusicPlayer.h"

@interface XKMusicPlayer ()

/// 播放器对象
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic, strong) id timeObserve;

/// 播放器状态
@property (nonatomic, assign) XKMusicPlayerStatus status;
/// 记录是否为本地文件
@property (nonatomic, assign) BOOL isLocalMusic;

@end

@implementation XKMusicPlayer

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static XKMusicPlayer *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[XKMusicPlayer alloc] init];
    });
    return instance;
}

#pragma mark -- Setter

- (void)setMusicUrlString:(NSString *)musicUrlString {
    _musicUrlString = musicUrlString;
    [self configPlayer];
}

- (void)setProgress:(NSInteger)progress {
    _progress = progress;
    CMTime dragedCMTime = CMTimeMake(progress, 1);
    [self.player seekToTime:dragedCMTime];
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    // 如果playerItem就是当前的_playerItem 直接返回
    if (_playerItem == playerItem) {
        return;
    }
    // 要重置_playerItem之前 先移除观察者
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    // 添加观察者
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        // 缓冲区空了 需要等待数据
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        // 缓冲区有足够数据可以播放了
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setStatus:(XKMusicPlayerStatus)status {
    _status = status;
    if (self.delegate && [self.delegate respondsToSelector:@selector(xkMusicPlayer:statusChanged:)]) {
        [self.delegate xkMusicPlayer:self statusChanged:self.status];
    }
}

#pragma mark -- 私有方法

- (void)configPlayer {
    self.urlAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:self.musicUrlString]];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    // 这里每次都去创建新的播放器对象 replaceCurrentItemWithPlayerItem: 这个方法会阻塞线程
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self createTimer];
    // 如果musicUrlString是以localhost开头 说明这是一个已经缓存了的文件
    if ([self.musicUrlString hasPrefix:@"file"]) {
        self.status = XKMusicPlayerStatusPlaying;
        self.isLocalMusic = YES;
    } else {
        self.status = XKMusicPlayerStatusBuffering;
    }
    [self.player play];
}

- (void)createTimer {
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time) {
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            NSInteger currentTime = (NSInteger)CMTimeGetSeconds([currentItem currentTime]);
            CGFloat totalTime = (CGFloat)currentItem.duration.value / currentItem.duration.timescale;
            CGFloat value = CMTimeGetSeconds([currentItem currentTime]) / totalTime;
            if (weakSelf.delegate &&[weakSelf.delegate respondsToSelector:@selector(xkMusicPlayer:totalTime:currentTime:progress:)]) {
                [weakSelf.delegate xkMusicPlayer:weakSelf totalTime:totalTime currentTime:currentTime progress:value];
            }
        }
    }];
}


/**
 计算缓存进度
 
 @return 缓存进度
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}

- (void)bufferingSomeSecond {
    self.status = XKMusicPlayerStatusBuffering;
    __block BOOL isBuffering = NO;
    if (isBuffering) {
        return;
    }
    isBuffering = YES;
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self play];
        isBuffering = NO;
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
    });
}

#pragma mark -- 通知方法

- (void)playDidEnd:(NSNotification *)notification {
    self.status = XKMusicPlayerStatusEnded;
    if (self.delegate && [self.delegate respondsToSelector:@selector(xkMusicPlayerDidEndPlay:)]) {
        [self.delegate xkMusicPlayerDidEndPlay:self];
    }
}

#pragma mark -- 观察者方法

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            self.status = XKMusicPlayerStatusPlaying;
        } else {
            self.status = XKMusicPlayerStatusError;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        // 这里将缓存的进度传出去
        if (self.delegate && [self.delegate respondsToSelector:@selector(xkMusicPlayer:cacheProgress:)]) {
            if (self.isLocalMusic) {
                [self.delegate xkMusicPlayer:self cacheProgress:1];
            } else {
                [self.delegate xkMusicPlayer:self cacheProgress:timeInterval / totalDuration];
            }
        }
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        if (self.playerItem.playbackBufferEmpty) {
            self.status = XKMusicPlayerStatusBuffering;
            [self bufferingSomeSecond];
        }
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        if (self.playerItem.playbackLikelyToKeepUp && self.status == XKMusicPlayerStatusBuffering) {
            self.status = XKMusicPlayerStatusPlaying;
        }
    }
}

#pragma mark -- 公共方法

- (void)play {
    if (self.status == XKMusicPlayerStatusPaused) {
        self.status = XKMusicPlayerStatusPlaying;
    }
    [self.player play];
}

- (void)pause {
    if (self.status == XKMusicPlayerStatusPlaying) {
        self.status = XKMusicPlayerStatusPaused;
    }
    [self.player pause];
}

@end
