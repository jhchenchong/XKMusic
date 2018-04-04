//
//  XKMusicCoverView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/2.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKDiskView.h"

@protocol XKMusicCoverViewDelegate<NSObject>

@optional

- (void)scrollDidScroll;
- (void)scrollDidChangeModel:(XKMusicModel *)model;

@end

@class XKMusicModel;
@interface XKMusicCoverView : UIView

@property (nonatomic, weak) id<XKMusicCoverViewDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t didTapCellBlock;

- (void)setupMusicModels:(NSArray<XKMusicModel *> *)models index:(NSInteger)currentIndex;
- (void)resetMusicModels:(NSArray<XKMusicModel *> *)models;

- (void)scrollChangeIsNext:(BOOL)isNext finished:(dispatch_block_t)finished;
- (void)playedWithAnimated:(BOOL)animated;
- (void)pausedWithAnimated:(BOOL)animated;
- (void)resetCover;

@end

@interface XKMusicCoverViewCell : XKCustomCollectionViewCell

@property (nonatomic, strong, readonly) XKDiskView *diskView;
@property (nonatomic, copy) NSString *imageURL;

@end
