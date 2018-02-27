//
//  ColorUtil.h
//  APPSummary
//
//  Created by xubojoy on 2018/2/26.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ColorUtil : NSObject
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(float)alpha;
+ (UIColor *) randomColor;
@end
