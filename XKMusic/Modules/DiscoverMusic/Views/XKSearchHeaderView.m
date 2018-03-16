//
//  XKSearchHeaderView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/11.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKSearchHeaderView.h"
#import "XKCustomHotSearchTagsView.h"

@interface XKSearchHeaderView ()

@property (nonatomic, strong) XKCustomHotSearchTagsView *searchTagsView;
@property (nonatomic, assign) CGFloat lableHeight;

@end

@implementation XKSearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self addSubview:topView];
    
    QMUIButton *button = [[QMUIButton alloc] init];
    [button setImagePosition:QMUIButtonImagePositionRight];
    button.spacingBetweenImageAndTitle = 5;
    [button setImage:UIImageMake(@"cm2_search_icn_arr") forState:UIControlStateNormal];
    [button setTitle:@"歌手分类" forState:UIControlStateNormal];
    button.titleLabel.font = UIFontMake(15);
    [button setTitleColor:UIColorGray forState:UIControlStateNormal];
    [button sizeToFit];
    [topView addSubview:button];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorSeparator;
    [self addSubview:lineView];
    
    QMUILabel *label = [[QMUILabel alloc] init];
    label.text = @"热门搜索";
    label.font = UIFontMake(12);
    label.textColor = UIColorGray;
    [label sizeToFit];
    self.lableHeight = label.mj_h;
    [self addSubview:label];
    
    self.searchTagsView = [[XKCustomHotSearchTagsView alloc] initWithTagTexts:@[@"node.js", @"java", @"oc", @"浪漫恋星空", @"123455", @"123", @"计算方法", @"4444", @"2333", @"124"] width:SCREEN_WIDTH - 30];
    [self addSubview:self.searchTagsView];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topView.mas_centerX);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(PixelOne);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(lineView.mas_bottom).offset(20);
    }];
    [self.searchTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(label.mas_bottom).offset(5);
        make.height.mas_equalTo(self.searchTagsView.mj_h);
    }];
}

- (CGFloat)headerViewHeight {
    return self.searchTagsView.mj_h + 79 + self.lableHeight;
}

@end
