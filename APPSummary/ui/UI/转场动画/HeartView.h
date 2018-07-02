//
//  HeartView.h
//  APPSummary
//
//  Created by xubojoy on 2018/6/28.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeartView : UIView
/**
 * 比率
 */
@property (nonatomic,assign) CGFloat rate;
/**
 * 填充的颜色
 */
@property (nonatomic,strong) UIColor *fillColor;
/**
 * 线条的颜色
 */
@property (nonatomic,strong) UIColor *strokeColor;
/**
 * 线条的宽度
 */
@property (nonatomic,assign) CGFloat lineWidth;
@end
