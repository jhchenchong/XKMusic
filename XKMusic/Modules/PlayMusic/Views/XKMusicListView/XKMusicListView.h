//
//  XKMusicListView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/28.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XKMusicModel;
@interface XKMusicListView : UIView

@property (nonatomic, copy) NSArray<XKMusicModel *> *musicModels;
@property (nonatomic, assign) XKPlayerPlayStyle playStyle;
@property (nonatomic, copy) dispatch_block_t styleButtonBlock;
@property (nonatomic, copy) dispatch_block_t allButtonBlock;
@property (nonatomic, copy) dispatch_block_t deleteButtonBlock;
@property (nonatomic, copy) dispatch_block_t closeButtonBlock;
@property (nonatomic, copy) void(^listDeleteButtonBlock)(XKMusicModel *model);
@property (nonatomic, copy) dispatch_block_t linkButtonBlock;
@property (nonatomic, copy) void(^didSelectRowAtIndexPathBlock)(NSIndexPath *indexPath);

@property (nonatomic, assign) BOOL shouldScroll;

@end

@interface XKMusicListCell : XKCustomCell

@property (nonatomic, strong) XKMusicModel *model;
@property (nonatomic, copy) void(^deleteButtonBlock)(XKMusicModel *model);
@property (nonatomic, copy) dispatch_block_t linkButtonBlock;

@end
