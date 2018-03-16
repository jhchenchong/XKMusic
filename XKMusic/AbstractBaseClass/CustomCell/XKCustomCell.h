//
//  XKCustomCell.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKCellDataAdapter.h"

@class XKCustomCell;

@protocol XKCustomCellDelegate <NSObject>

@optional

- (void)customCell:(XKCustomCell *)cell event:(id)event;

@end

@interface XKCustomCell : QMUITableViewCell

#pragma mark - Propeties.

@property (nonatomic, weak) id <XKCustomCellDelegate> delegate;

@property (nonatomic, weak) XKCellDataAdapter *dataAdapter;

@property (nonatomic, weak) id data;

@property (nonatomic, weak) NSIndexPath *indexPath;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIViewController *controller;

@property (nonatomic) BOOL display;

#pragma mark - Method you should overwrite.

- (void)setupCell;

- (void)buildSubview;

- (void)loadContent;

- (NSMutableAttributedString *)handleStringWithString:(NSString *)string attributes:(NSDictionary<NSString *,id> *)attributes rang:(NSRange)rang;

+ (CGFloat)cellHeightWithData:(id)data;

#pragma mark - Useful method.

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated;

- (void)selectedEvent;

- (void)delegateEvent;

#pragma mark - Constructor method.

+ (XKCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height type:(NSInteger)type;

+ (XKCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height cellWidth:(CGFloat)cellWidth type:(NSInteger)type;

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type;

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height;

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data;

+ (XKCellDataAdapter *)dataAdapterWithCellHeight:(CGFloat)height;

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type;

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data;

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapter;

+ (XKCellDataAdapter *)layoutTypeAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type;

+ (XKCellDataAdapter *)layoutTypeAdapterWithData:(id)data type:(NSInteger)type;

+ (XKCellDataAdapter *)layoutTypeAdapterWithData:(id)data;

+ (XKCellDataAdapter *)layoutTypeAdapter;

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter indexPath:(NSIndexPath *)indexPath;

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter;

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter delegate:(id <XKCustomCellDelegate>)delegate indexPath:(NSIndexPath *)indexPath;

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter
                      delegate:(id <XKCustomCellDelegate>)delegate
                     tableView:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath;

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerToTableView:(UITableView *)tableView;

@end

#pragma mark - UITableView category.

@interface UITableView (XKCustomCell)

- (XKCustomCell *)dequeueReusableCellAndLoadDataWithAdapter:(XKCellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath;

- (XKCustomCell *)dequeueReusableCellAndLoadDataWithAdapter:(XKCellDataAdapter *)adapter delegate:(id <XKCustomCellDelegate>)delegate indexPath:(NSIndexPath *)indexPath;

- (CGFloat)cellHeightWithAdapter:(XKCellDataAdapter *)adapter;

@end
