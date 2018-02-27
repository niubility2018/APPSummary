//
//  UILabel+Custom.h
//  styler
//
//  Created by wangwanggy820 on 14-6-28.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

-(void)setParagrahStyle:(NSDictionary *)contentDict titleColor:(UIColor *)titleColor contentColor:(UIColor *)contentColor;

-(float) realWidth;
-(float) realHeight;
/**
 修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets yf_contentInsets;


//计算文字实际高度
extern float CalcTextHight(UIFont *font, NSString* text, CGFloat width);
extern float CalcTextWidth(UIFont *font, NSString* text, CGFloat width);

@end
