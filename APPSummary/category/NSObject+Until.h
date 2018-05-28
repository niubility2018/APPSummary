//
//  NSObject+Until.h
//  mobileWalletOfYiBao
//
//  Created by xubojoy on 2018/5/15.
//  Copyright © 2018年 fengbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Until)

/*! @method swizzleMethod:withMethod:error:
 @abstract 对系统方法进行替换
 @param originalSelector 想要替换的方法
 @param swizzledSelector 实际替换为的方法
 @param error 替换过程中出现的错误，如果没有错误为nil
 */
+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error;

@end
