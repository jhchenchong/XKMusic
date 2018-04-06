//
//  XKSongListHeaderCell.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/4/6.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKCustomCell.h"

@interface XKSongListHeaderCell : XKCustomCell

@property (nonatomic, copy) void(^DidClickHeaderCellButtonBlock)(XKSonglistHeaderButtonType type);

@end
