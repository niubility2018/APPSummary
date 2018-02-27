//
//  UIView+Position.m
//  styler
//
//  Created by wangwanggy820 on 14-4-2.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

-(float)bottomY{
    return self.frame.size.height + self.frame.origin.y;
}

-(float)rightX
{
    return self.frame.size.width + self.frame.origin.x;
}

-(void)addStrokeBorderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color
{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = color.CGColor;
}

@end