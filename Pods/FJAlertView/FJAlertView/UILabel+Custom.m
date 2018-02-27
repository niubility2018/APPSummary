//
//  UILabel+Custom.m
//  styler
//
//  Created by wangwanggy820 on 14-6-28.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "UILabel+Custom.h"
#import <objc/runtime.h>
#import "Constant.h"
/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@implementation UILabel (Custom)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(yf_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(yf_sizeThatFits:));
    });
}

- (void)yf_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.yf_contentInsets;
    [self yf_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)yf_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.yf_contentInsets;
    size = [self yf_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedYf_contentInsets;
- (void)setYf_contentInsets:(UIEdgeInsets)yf_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedYf_contentInsets, [NSValue valueWithUIEdgeInsets:yf_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)yf_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedYf_contentInsets) UIEdgeInsetsValue];
}

-(void)setParagrahStyle:(NSDictionary *)contentDict titleColor:(UIColor *)titleColor contentColor:(UIColor *)contentColor
{
    NSArray *titles = [contentDict allValues];
    NSArray *contents = [contentDict allKeys];
    NSString *allContent = @"";
    for (int i = 0; i<contentDict.count; i++) {
        if (i == 0) {
            allContent = [NSString stringWithFormat:@"%@\n%@",titles[i],contents[i]];
        }else{
            allContent = [NSString stringWithFormat:@"%@\n%@\n%@",allContent,titles[i],contents[i]];
        }
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:allContent];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:general_padding/2];
    [attr addAttribute:NSParagraphStyleAttributeName
                 value:paragrahStyle range:NSMakeRange(0, [allContent length])];
    [attr addAttribute:NSForegroundColorAttributeName
                 value:contentColor range:NSMakeRange(0, allContent.length)];
    int lenght = 0;
    for (int i = 0; i< titles.count; i++) {
        NSString *title = titles[i];
        NSString *content = contents[i];
        [attr addAttribute:NSForegroundColorAttributeName value:titleColor
                     range:NSMakeRange(lenght, title.length)];
        lenght += content.length + title.length + 2;
    }
    
    UIFont *font = [UIFont systemFontOfSize:font_14_size];
    [attr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, allContent.length)];
    
    self.attributedText = attr;
}

-(float) realWidth
{
//    return  [self.text sizeWithFont:self.font].width;
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
}

-(float) realHeight
{
    //    return  [self.text sizeWithFont:self.font].width;
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].height;
}


float CalcTextHight(UIFont *font, NSString* text, CGFloat width) {
    CGSize sz = [text boundingRectWithSize:CGSizeMake(width, 10000.0) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return sz.height;
}

float CalcTextWidth(UIFont *font, NSString* text, CGFloat width) {
    CGSize sz = [text boundingRectWithSize:CGSizeMake(width, font.lineHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return sz.width;
}


@end
