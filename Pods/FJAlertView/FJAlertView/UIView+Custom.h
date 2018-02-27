//
//  UIView+Position.h
//  styler
//
//  Created by wangwanggy820 on 14-4-2.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Custom)

-(float)bottomY;
-(float)rightX;
-(void)addStrokeBorderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color;

@end
