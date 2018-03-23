//
//  XKMusicCoverView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKMusicModel.h"

@protocol XKMusicCoverViewDelegate<NSObject>

@optional

- (void)scrollDidScroll;
- (void)scrollWillChangeModel:(XKMusicModel *)model;
- (void)scrollDidChangeModel:(XKMusicModel *)model;
- (void)scrollDidEnd:(UIScrollView *)scrollView;

@end

@interface XKMusicCoverView : UIView

@property (nonatomic, weak) id<XKMusicCoverViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *diskScrollView;

- (void)setupMusicList:(NSArray *)musics index:(NSInteger)currentIndex;
- (void)resetMusicList:(NSArray *)musics index:(NSInteger)currentIndex;

// 滑动切换歌曲
- (void)scrollChangeIsNext:(BOOL)isNext finished:(dispatch_block_t)finished;
- (void)playedWithAnimated:(BOOL)animated;
- (void)pausedWithAnimated:(BOOL)animated;
- (void)resetCover;

@end
