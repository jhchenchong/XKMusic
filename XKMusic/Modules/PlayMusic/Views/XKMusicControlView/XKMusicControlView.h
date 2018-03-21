//
//  XKMusicControlView.h
//  XKMusic
//
//  Created by 浪漫恋星空 on 2018/3/21.
//  Copyright © 2018年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XKMusicControlView;

@protocol XKMusicControlViewDelegate <NSObject>

// 按钮点击
- (void)controlView:(XKMusicControlView *)controlView didClickLove:(UIButton *)loveBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickDownload:(UIButton *)downloadBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickComment:(UIButton *)commentBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickMore:(UIButton *)moreBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickLoop:(UIButton *)loopBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickPrev:(UIButton *)prevBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickPlay:(UIButton *)playBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickNext:(UIButton *)nextBtn;
- (void)controlView:(XKMusicControlView *)controlView didClickList:(UIButton *)listBtn;

// 滑杆滑动及点击
- (void)controlView:(XKMusicControlView *)controlView didSliderTouchBegan:(float)value;
- (void)controlView:(XKMusicControlView *)controlView didSliderTouchEnded:(float)value;
- (void)controlView:(XKMusicControlView *)controlView didSliderValueChange:(float)value;
- (void)controlView:(XKMusicControlView *)controlView didSliderTapped:(float)value;

@end

@interface XKMusicControlView : UIView

@property (nonatomic, weak) id<XKMusicControlViewDelegate> delegate;
@property (nonatomic, assign) XKPlayerPlayStyle style;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, copy) NSString *currentTime;
@property (nonatomic, copy) NSString *totalTime;
@property (nonatomic, assign) float value;
@property (nonatomic, assign) BOOL is_love;

- (void)setupInitialData;

- (void)showLoadingAnim;
- (void)hideLoadingAnim;

- (void)setupPlayBtn;
- (void)setupPauseBtn;

@end
