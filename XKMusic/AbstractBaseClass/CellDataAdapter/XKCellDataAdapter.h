//
//  XKCellDataAdapter.h
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKCellDataAdapter : NSObject

/// 重用标识符
@property (nonatomic, strong) NSString *cellReuseIdentifier;

/// 数据源
@property (nonatomic, strong) id data;

/// cell的高度 只适用于tableView
@property (nonatomic, assign) CGFloat cellHeight;

/// cell的宽度 只适用于tableView
@property (nonatomic, assign) CGFloat cellWidth;

/// cell的type
@property (nonatomic, assign) NSInteger cellType;

/**
 *  XKCellDataAdapter 为UITableView提供的便利构造方法.
 *
 *  @param cellReuseIdentifiers 重用标识符.
 *  @param data                 数据源(可以为空).
 *  @param cellHeight           高度
 *  @param cellType             类型
 *
 *  @return CellDataAdapter
 */
+ (instancetype)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                  data:(id)data
                                            cellHeight:(CGFloat)cellHeight
                                              cellType:(NSInteger)cellType;

/**
 *  XKCellDataAdapter 为UITableView提供的便利构造方法.
 *
 *  @param cellReuseIdentifiers 重用标识符.
 *  @param data                 数据源(可以为空).
 *  @param cellHeight           高度
 *  @param cellWidth            宽度
 *  @param cellType             类型
 *
 *  @return CellDataAdapter
 */
+ (instancetype)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                  data:(id)data
                                            cellHeight:(CGFloat)cellHeight
                                             cellWidth:(CGFloat)cellWidth
                                              cellType:(NSInteger)cellType;

/**
 *  XKCellDataAdapter 为UICollectionView提供的便利构造方法.
 *
 *  @param cellReuseIdentifiers 重用标识符.
 *  @param data                 数据源(可以为空).
 *  @param cellType             类型
 *
 *  @return CellDataAdapter
 */
+ (instancetype)collectionCellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                            data:(id)data
                                                        cellType:(NSInteger)cellType;

#pragma mark - Optional properties.

/// tableView
@property (nonatomic, weak) UITableView *tableView;

/// collectionView
@property (nonatomic, weak) UICollectionView *collectionView;

/// tableView indexPath
@property (nonatomic, weak) NSIndexPath *indexPath;

@end
