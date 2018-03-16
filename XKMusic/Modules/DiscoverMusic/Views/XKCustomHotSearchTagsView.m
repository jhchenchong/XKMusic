//
//  XKCustomHotSearchTagsView.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/9.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "XKCustomHotSearchTagsView.h"

@interface XKCustomHotSearchTagsView()

@property (nonatomic, strong) NSArray<NSString *> *tagTexts;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) NSArray *tagsLabels;

@end

@implementation XKCustomHotSearchTagsView

- (instancetype)initWithTagTexts:(NSArray<NSString *> *)tagTexts width:(CGFloat)width {
    if (self = [super init]) {
        self.tagTexts = tagTexts;
        self.width = width;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    NSMutableArray *tagsM = [NSMutableArray array];
    for (int i = 0; i < self.tagTexts.count; i++) {
        UILabel *label = [self labelWithTitle:self.tagTexts[i]];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [self addSubview:label];
        [tagsM addObject:label];
    }
    
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UILabel *subView = self.subviews[i];
        if (subView.mj_w > self.width) subView.mj_w = self.width;
        if (currentX + subView.mj_w + 10 * countRow > self.width) {
            subView.mj_x = 0;
            subView.mj_y = (currentY += subView.mj_h) + 10 * ++countCol;
            currentX = subView.mj_w;
            countRow = 1;
        } else {
            subView.mj_x = (currentX += subView.mj_w) - subView.mj_w + 10 * countRow;
            subView.mj_y = currentY + 10 * countCol;
            countRow ++;
        }
    }
    self.mj_h = CGRectGetMaxY(self.subviews.lastObject.frame);
}

- (UILabel *)labelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:15];
    label.text = title;
    label.textColor = [XKColorHelper textMainColor];
    label.backgroundColor = [UIColor qmui_colorWithHexString:@"#fafafa"];
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    
    [label sizeToFit];
    label.mj_w += 20;
    label.mj_h += 14;
    label.backgroundColor = [UIColor clearColor];
    label.layer.borderColor = UIColorGray.CGColor;
    label.layer.borderWidth = 0.5;
    label.layer.cornerRadius = label.mj_h * 0.5;
    return label;
}

- (void)tagDidCLick:(UITapGestureRecognizer *)sender {
    NSLog(@"点击了热门搜索");
}

@end
