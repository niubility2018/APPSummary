//
//  DrawView.h
//  RuntimeTest
//
//  Created by xubojoy on 2018/1/22.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
//管理画板所有路径
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, assign) float lineWidth;
@property (nonatomic, strong) UIColor *lineColor;

- (void)cleanAll;
- (void)rollback;
- (void)eraser;

@end
