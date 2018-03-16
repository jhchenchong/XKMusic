//
//  XKBaseComponent.m
//  XKComponentTableView
//
//  Created by 浪漫恋星空 on 2018/2/12.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKBaseComponent.h"

@interface XKBaseComponent ()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation XKBaseComponent

+ (instancetype)componentWithTableView:(UITableView *)tableView {
    return [self componentWithTableView:tableView delegate:nil];
}

+ (instancetype)componentWithTableView:(UITableView *)tableView delegate:(id<XKTableComponentDelegate>)delegate {
    id<XKTableComponent> component = [[self alloc] initWithTableView:tableView delegate:delegate];
    return component;
}

- (instancetype)init {
    return [self initWithTableView:nil];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    return [self initWithTableView:tableView delegate:nil];
}

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<XKTableComponentDelegate>)delegate {
    self = [super init];
    if (self) {
        self.cellIdentifier = [NSString stringWithFormat:@"%@-Cell", NSStringFromClass(self.class)];
        self.headerIdentifier = [NSString stringWithFormat:@"%@-Header", NSStringFromClass(self.class)];
        self.footerIdentifier = [NSString stringWithFormat:@"%@-Footer", NSStringFromClass(self.class)];
        self.tableView = tableView;
        self.delegate = delegate;
        
        [self registerWithTableView:tableView];
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 0;
}

- (CGFloat)heightForComponentHeader {
    return 0.f;
}

- (CGFloat)heightForComponentFooter {
    return CGFLOAT_MIN;
}

- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index {
    return 0.f;
}

- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (__kindof UIView *)headerForTableView:(UITableView *)tableView {
    return nil;
}

- (__kindof UIView *)footerForTableView:(UITableView *)tableView {
    return nil;
}

- (void)didSelectItemAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(tableComponent:didTapItemAtIndex:)]) {
        [self.delegate tableComponent:self didTapItemAtIndex:index];
    }
}

- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section {
    
}

- (void)registerWithTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
}

- (void)setNeedUpdateHeightForSection:(NSInteger)section {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, NO, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        [self.tableView reloadData];
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

@end
