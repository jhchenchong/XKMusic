//
//  XKCustomHeaderFooterView.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKCellHeaderFooterDataAdapter.h"

@class XKCustomHeaderFooterView;

@protocol XKCustomHeaderFooterViewDelegate <NSObject>

@optional

- (void)customHeaderFooterView:(XKCustomHeaderFooterView *)customHeaderFooterView event:(id)event;

@end

@interface XKCustomHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id <XKCustomHeaderFooterViewDelegate> sdelegate;

@property (nonatomic, weak) XKCellHeaderFooterDataAdapter *dataAdapter;

@property (nonatomic, weak) id data;

@property (nonatomic) NSInteger section;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIViewController *controller;

#pragma mark - Some useful method.

- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color;

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerToTableView:(UITableView *)tableView;

#pragma mark - Method override by subclass.

- (void)setupHeaderFooterView;

- (void)buildSubview;

- (void)loadContent;

+ (CGFloat)heightWithData:(id)data;

#pragma mark - Adapters.

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier
                                                             data:(id)data
                                                           height:(CGFloat)height
                                                             type:(NSInteger)type;

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data
                                                height:(CGFloat)height
                                                  type:(NSInteger)type;

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithData:(id)data
                                                height:(CGFloat)height;

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height
                                                    type:(NSInteger)type;

+ (XKCellHeaderFooterDataAdapter *)dataAdapterWithHeight:(CGFloat)height;

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithReuseIdentifier:(NSString *)reuseIdentifier
                                                                            data:(id)data
                                                                            type:(NSInteger)type;

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data
                                                                 type:(NSInteger)type;

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data;

+ (XKCellHeaderFooterDataAdapter *)fixedHeightTypeDataAdapter;

@end
