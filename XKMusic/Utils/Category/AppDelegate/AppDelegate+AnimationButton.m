//
//  AppDelegate+AnimationButton.m
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/19.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import "AppDelegate+AnimationButton.h"

@implementation AppDelegate (AnimationButton)

static char *AnimationButtonKey = "AnimationButtonKey";

- (void)setAnimationButton:(QMUIButton *)animationButton {
    objc_setAssociatedObject(self, AnimationButtonKey, animationButton, OBJC_ASSOCIATION_RETAIN);
}

- (QMUIButton *)animationButton {
    return objc_getAssociatedObject(self, AnimationButtonKey);
}

- (void)configAnimationButton {
    self.animationButton = [[QMUIButton alloc] init];
    [self.animationButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_playing1"] forState:UIControlStateNormal];
    [self.animationButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_playing1_prs"] forState:UIControlStateHighlighted];
    [self.window addSubview:self.animationButton];
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    [self.animationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.window).offset(statusBarFrame.size.height);
        make.right.equalTo(self.window).offset(-4);
        make.width.height.mas_equalTo(44);
    }];
    [[self.animationButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[XKAppDelegateHelper visibleViewController].navigationController pushViewController:XKPlayerVC animated:YES];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kAnimationButtnStateChanged object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        if (self.animationButton.selected) {
            NSMutableArray *images = @[].mutableCopy;
            
            for (NSInteger i = 0; i < 6; i++) {
                NSString *imageName = [NSString stringWithFormat:@"cm2_topbar_icn_playing%zd", i + 1];
                [images addObject:UIImageMake(imageName)];
            }
            for (NSInteger i = 6; i > 0; i--) {
                NSString *imageName = [NSString stringWithFormat:@"cm2_topbar_icn_playing%zd", i];
                [images addObject:UIImageMake(imageName)];
            }
            
            self.animationButton.imageView.animationImages = images;
            self.animationButton.imageView.animationDuration = 0.75;
            [self.animationButton.imageView startAnimating];
            
        } else {
            if (self.animationButton.imageView.isAnimating) {
                [self.animationButton.imageView stopAnimating];
            }
            [self.animationButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_playing1"] forState:UIControlStateNormal];
            [self.animationButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_playing1_prs"] forState:UIControlStateHighlighted];
        }
    }];
}

- (void)showAnimationButton {
    self.animationButton.hidden = NO;
}

- (void)hideAnimationButton {
    self.animationButton.hidden = YES;
}

@end
