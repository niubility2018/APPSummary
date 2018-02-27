//
//  FJAlertView.m
//  funjoy
//
//  Created by xubojoy on 2018/1/17.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "FJAlertView.h"
#import "UIView+KGViewExtend.h"
#import "UILabel+Custom.h"
#import "Constant.h"
#import "ColorUtils.h"
@implementation FJAlertView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle{
    self = [super init];
    if (self) {
        self.frame = frame;
        _title = title;
        _message = message;
        _buttonTitle = buttonTitle;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    //毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _effectView.frame = self.bounds;
    _effectView.alpha = 0.8;
    [self addSubview:_effectView];
//    白色背景view
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(general_margin, 0, screen_width-2*general_margin, 80)];
    self.contentView.backgroundColor = [ColorUtils colorWithHexString:common_purple_color];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.center = self.center;
    [self addSubview:self.contentView];

    
//    CABasicAnimation *theAnimation;
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    theAnimation.duration=2;
//    theAnimation.removedOnCompletion = YES;
//    theAnimation.fromValue = [NSNumber numberWithFloat:0];
//    theAnimation.toValue = [NSNumber numberWithFloat:1];
//    [self.contentView.layer addAnimation:theAnimation forKey:@"animateTransform"];
//    缩放动画  usingSpringWithDamping 弹性属性
    self.contentView.layer.affineTransform = CGAffineTransformMakeScale(0,0);
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.contentView.layer.affineTransform = CGAffineTransformMakeScale(1,1);
    } completion:^(BOOL finished) {

    }];
    
//    标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.contentView.frame.size.width, general_space)];
    _titleLabel.textColor = [ColorUtils colorWithHexString:green_light_color];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:font_15_size];
    [self.contentView addSubview:_titleLabel];
    
    self.contentBgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom+5, self.contentView.frame.size.width, self.contentView.frame.size.height-5-_titleLabel.bottom)];
    self.contentBgScrollView.backgroundColor = [ColorUtils colorWithHexString:common_purple_color];
    self.contentBgScrollView.scrollEnabled = YES;
    self.contentBgScrollView.showsVerticalScrollIndicator = YES;
    [self.contentView addSubview:self.contentBgScrollView];
    self.contentBgScrollView.contentSize = CGSizeMake(screen_width-2*general_margin, 80);
//    内容
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.backgroundColor = [ColorUtils colorWithHexString:common_purple_color];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentBgScrollView addSubview:_messageLabel];

//    关闭按钮
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake((screen_width-40)/2, self.contentView.bottom+15, 40, 40);
    [self addSubview:self.closeBtn];
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_del_cross"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];

    self.closeBtn.layer.cornerRadius = 20;
    self.closeBtn.layer.masksToBounds = YES;
    self.closeBtn.layer.borderWidth = splite_line_height;
    self.closeBtn.layer.borderColor = [ColorUtils colorWithHexString:splite_line_color].CGColor;
    
    [self updateViewFrame];
}
//更新frame
- (void)updateViewFrame{
    
    _titleLabel.text = _title;
    
    _messageLabel.text = _message;
    [_messageLabel sizeToFit];
    float messageLabelSizeH = CalcTextHight([UIFont systemFontOfSize:15], _message, ((screen_width-2*general_margin)-20));
    self.contentBgScrollView.contentSize = CGSizeMake((screen_width-2*general_margin),messageLabelSizeH);
    CGRect contentViewFrame = self.contentView.frame;
    if (messageLabelSizeH > screen_height/2) {
        contentViewFrame.size.height = 400;
    }else{
        contentViewFrame.size.height = messageLabelSizeH+40+splite_line_height;
    }
    self.contentView.frame = contentViewFrame;
    CGRect closeBtnFrame = self.closeBtn.frame;
    closeBtnFrame.origin.y = self.contentView.bottom+15;
    self.closeBtn.frame = closeBtnFrame;
    
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)closeBtnClick{
    self.contentView.layer.affineTransform = CGAffineTransformMakeScale(1,1);
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.layer.affineTransform = CGAffineTransformMakeScale(0,0);
        self.effectView.effect = nil;
        [self.closeBtn removeFromSuperview];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
