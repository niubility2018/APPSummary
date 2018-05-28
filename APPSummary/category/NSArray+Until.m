//
//  NSArray+Until.m
//  mobileWalletOfYiBao
//
//  Created by xubojoy on 2018/5/15.
//  Copyright © 2018年 fengbing. All rights reserved.
//

#import "NSArray+Until.h"
#import "NSObject+Until.h"
@implementation NSArray (Until)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(yb_objectAtIndex:) error:nil];
        };
    });
}


- (id)yb_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self yb_objectAtIndex:index];
    }
    
    return nil;//越界返回为nil
}

@end
