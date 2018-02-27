//
//  FJAlertView.h
//  funjoy
//
//  Created by xubojoy on 2018/1/17.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJAlertView : UIView
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UILabel *messageLabel;


@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIScrollView *contentBgScrollView;

/**
 添加毛玻璃
 */
@property (nonatomic, strong) UIVisualEffectView *effectView;


/**
 初始化view
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle;

/**
 弹出自定义alertView
 */
- (void)show;
@end
