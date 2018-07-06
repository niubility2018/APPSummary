//
//  ProvinceSampleKeyboardView.h
//  DaBaiCai
//
//  Created by DBC on 2018/6/8.
//  Copyright © 2018年 大白菜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ProvinceSampleKeyboardViewBlock)(id obj);

#define kProvinceSampleKeyboardViewHeight      204

@interface ProvinceSampleKeyboardView : UIView
@property (nonatomic, copy) ProvinceSampleKeyboardViewBlock block;
@property (nonatomic, copy) dispatch_block_t deleteBlock;

@property (nonatomic, assign) BOOL hideDeleteButton;

+ (instancetype)fretchSelfXib;

+(void)hideWithAnimation:(BOOL)animated;
+(ProvinceSampleKeyboardView *)showWidthAnimation:(BOOL)animated;
@end
