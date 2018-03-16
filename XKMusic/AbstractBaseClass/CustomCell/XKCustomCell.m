//
//  XKCustomCell.m
//  XKUniversallyProject
//
//  Created by 浪漫恋星空 on 2017/10/25.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKCustomCell.h"

@implementation XKCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCell];
        
        [self buildSubview];
    }
    
    return self;
}

- (void)setupCell {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
}

- (NSMutableAttributedString *)handleStringWithString:(NSString *)string attributes:(NSDictionary<NSString *,id> *)attributes rang:(NSRange)rang {
    
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    [mStr addAttributes:attributes range:rang];
    
    return mStr;
}

- (void)delegateEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        
        [self.delegate customCell:self event:self.data];
    }
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 0.f;
}

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    [self loadContent];
}

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter
                     indexPath:(NSIndexPath *)indexPath {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    [self loadContent];
}

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter
                      delegate:(id <XKCustomCellDelegate>)delegate
                     indexPath:(NSIndexPath *)indexPath {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    _delegate    = delegate;
    [self loadContent];
}

- (void)loadContentWithAdapter:(XKCellDataAdapter *)dataAdapter
                      delegate:(id <XKCustomCellDelegate>)delegate
                     tableView:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath {
    
    _dataAdapter = dataAdapter;
    _data        = dataAdapter.data;
    _indexPath   = indexPath;
    _delegate    = delegate;
    _tableView   = tableView;
    [self loadContent];
}

#pragma mark - Normal type adapter.

+ (XKCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                     data:(id)data
                                               cellHeight:(CGFloat)height
                                                     type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [XKCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (XKCellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                     data:(id)data
                                               cellHeight:(CGFloat)height
                                                cellWidth:(CGFloat)cellWidth
                                                     type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [XKCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellWidth:cellWidth cellType:type];
}

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height type:type];
}

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height type:0];
}

+ (XKCellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 type:0];
}

+ (XKCellDataAdapter *)dataAdapterWithCellHeight:(CGFloat)height {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:nil cellHeight:height type:0];
}

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                                    data:(id)data
                                                                    type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [XKCellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier
                                                                data:data
                                                          cellHeight:[[self class] cellHeightWithData:data]
                                                            cellType:type];
}

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data type:(NSInteger)type {
    
    return [XKCellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                                data:data
                                                          cellHeight:[[self class] cellHeightWithData:data]
                                                            cellType:type];
}

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapterWithData:(id)data {
    
    return [XKCellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class])
                                                                data:data
                                                          cellHeight:[[self class] cellHeightWithData:data]
                                                            cellType:0];
}

+ (XKCellDataAdapter *)fixedHeightTypeDataAdapter {
    
    return [XKCellDataAdapter cellDataAdapterWithCellReuseIdentifier:NSStringFromClass([self class]) data:nil cellHeight:[[self class] cellHeightWithData:nil] cellType:0];
}

#pragma mark - Layout type adapter.

+ (XKCellDataAdapter *)layoutTypeAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data type:(NSInteger)type {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:reuseIdentifier data:data cellHeight:UITableViewAutomaticDimension type:type];
}

+ (XKCellDataAdapter *)layoutTypeAdapterWithData:(id)data type:(NSInteger)type {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:UITableViewAutomaticDimension type:type];
}

+ (XKCellDataAdapter *)layoutTypeAdapterWithData:(id)data {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:data cellHeight:UITableViewAutomaticDimension type:0];
}

+ (XKCellDataAdapter *)layoutTypeAdapter {
    
    return [[self class] dataAdapterWithCellReuseIdentifier:nil data:nil cellHeight:UITableViewAutomaticDimension type:0];
}

#pragma mark -

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (_tableView && _dataAdapter) {
        
        if (animated) {
            
            _dataAdapter.cellHeight = height;
            [_tableView beginUpdates];
            [_tableView endUpdates];
            
        } else {
            
            _dataAdapter.cellHeight = height;
            [_tableView reloadData];
        }
    }
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

@end

@implementation UITableView (XKCustomCell)

- (XKCustomCell *)dequeueReusableCellAndLoadDataWithAdapter:(XKCellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath {
    
    XKCustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithAdapter:adapter delegate:nil tableView:self indexPath:indexPath];
    
    return cell;
}

- (XKCustomCell *)dequeueReusableCellAndLoadDataWithAdapter:(XKCellDataAdapter *)adapter
                                                   delegate:(id <XKCustomCellDelegate>)delegate
                                                  indexPath:(NSIndexPath *)indexPath {
    XKCustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithAdapter:adapter delegate:delegate tableView:self indexPath:indexPath];
    
    return cell;
}

- (CGFloat)cellHeightWithAdapter:(XKCellDataAdapter *)adapter {
    
    return adapter.cellHeight;
}

@end
