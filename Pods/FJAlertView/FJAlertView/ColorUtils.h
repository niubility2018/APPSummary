//
//  ColorUtils.h
//  iUser
//
//  Created by System Administrator on 13-4-13.
//  Copyright (c) 2013年 珠元玉睿ray. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ColorUtils : NSObject

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(float)alpha;
+ (UIColor *) randomColor;
@end
