//
//  LicensePlateTextField.h
//  LicensePlateTextFieldDemo
//
//  Created by DBC on 2018/7/4.
//  Copyright © 2018年 DBC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LicensePlateTextField : UIView<UIKeyInput>
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong, readonly) NSString *numString; // 字母数组组合
@property (nonatomic, strong, readonly) NSString *sampleProvince; // 省份简称
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *pointColor;
@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, assign) NSInteger curentIndex; // 游标位置

@end

NS_ASSUME_NONNULL_END
