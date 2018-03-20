//
//  XKAdjustSectionsController.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/15.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKAdjustSectionsController.h"

@interface XKAdjustSectionsController ()

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XKAdjustSectionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
}

- (void)initDataSource {
    self.dataSource = @[].mutableCopy;
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"ColumnOrder"] ? [[NSUserDefaults standardUserDefaults] objectForKey:kColumnOrder] : @[@"0", @"1", @"2", @"3"];
    for (NSString *string in array) {
        [self.dataSource addObject:[self.dict valueForKey:string]];
    }
}

- (void)initSubviews {
    [super initSubviews];
    [XKCustomCell registerToTableView:self.tableView];
    self.tableView.backgroundColor = UIColorWhite;
    self.tableView.alwaysBounceVertical = NO;
    self.tableView.tableFooterView = self.footView;
    [self.tableView setEditing:YES animated:YES];
}

- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
    self.titleView.title = @"调整栏目顺序";
    [self configRightButtonItem];
    [XKAppDelegateHelper hideAnimationButton];
}

- (void)configRightButtonItem {
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:QMUINavigationButtonTypeNormal title:@"完成" position:QMUINavigationButtonPositionRight target:self action:@selector(handleRightBarButtonItemEvent)];
}

- (void)handleRightBarButtonItemEvent {
    XKBLOCK_EXEC(self.block)
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XKCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKCustomCell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textColor = [XKColorHelper textMainColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"想要调整首页栏目的顺序？按住右边的按钮拖动即可";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView *castView = (UITableViewHeaderFooterView *) view;
        castView.contentView.backgroundColor = UIColorWhite;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == destinationIndexPath.section && sourceIndexPath.row == destinationIndexPath.row) {
        NSLog(@"这里就不要做操作了");
    } else {
        NSString *title = self.dataSource[sourceIndexPath.row];
        [self.dataSource removeObject:title];
        [self.dataSource insertObject:title atIndex:destinationIndexPath.row];
        [self cacheTheKey];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)cacheTheKey {
    NSMutableArray *mutableArray = @[].mutableCopy;
    for (NSString *value in self.dataSource) {
        [self.dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:value]) {
                [mutableArray addObject:key];
                *stop = YES;
            }
        }];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:kColumnOrder];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        QMUILinkButton *linkButton = [[QMUILinkButton alloc] init];
        [linkButton setTitle:@"恢复默认排序" forState:UIControlStateNormal];
        [linkButton setTitleColor:UIColorGray forState:UIControlStateNormal];
        linkButton.titleLabel.font = UIFontMake(12);
        [_footView addSubview:linkButton];
        [linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_footView.mas_centerX);
            make.bottom.mas_equalTo(_footView.mas_bottom);
        }];
        XKWEAK
        [[linkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            XKSTRONG
            self.dataSource = @[@"推荐歌单", @"独家放送", @"最新音乐", @"主播电台"].mutableCopy;
            [[NSUserDefaults standardUserDefaults] setObject:@[@"0", @"1", @"2", @"3"] forKey:kColumnOrder];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tableView reloadData];
        }];
    }
    return _footView;
}

- (NSDictionary *)dict {
    if (!_dict) {
        _dict = @{@"0":@"推荐歌单", @"1":@"独家放送", @"2":@"最新音乐", @"3":@"主播电台"};
    }
    return _dict;
}

@end
