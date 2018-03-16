//
//  XKCustomCollectionViewCell.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/26.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKCellDataAdapter.h"
@class XKCustomCollectionViewCell;

@protocol XKCustomCollectionViewCellDelegate <NSObject>

@optional

- (void)customCollectionCell:(XKCustomCollectionViewCell *)cell event:(id)event;

@end

@interface XKCustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <XKCustomCollectionViewCellDelegate> delegate;

@property (nonatomic, weak) XKCellDataAdapter *dataAdapter;

@property (nonatomic, weak) id data;

@property (nonatomic, weak) NSIndexPath *indexPath;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIViewController *controller;

@property (nonatomic, assign) BOOL display;

#pragma mark - Method you should overwrite.

- (void)setupCell;

- (void)buildSubview;

- (void)loadContent;

- (void)contentOffset:(CGPoint)offset;

#pragma mark - Useful method.

- (void)selectedEvent;

#pragma mark - Constructor method.

+ (XKCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data type:(NSInteger)type;

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data;

+ (void)registerToCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerToCollectionView:(UICollectionView *)collectionView;

@end
