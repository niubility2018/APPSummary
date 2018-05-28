//
//  NSMutableArray+Until.m
//  mobileWalletOfYiBao
//
//  Created by xubojoy on 2018/5/15.
//  Copyright © 2018年 fengbing. All rights reserved.
//

#import "NSMutableArray+Until.h"
#import "NSObject+Until.h"
static const NSString *yb_defaultObject = @"defaultObject";

@implementation NSMutableArray (Until)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArrayM") swizzleMethod:
             @selector(objectAtIndex:) withMethod:@selector(yb_objectAtIndex:) error:nil];
            [objc_getClass("__NSArrayM") swizzleMethod:
             @selector(addObject:) withMethod:@selector(yb_addObject:) error:nil];
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


-(void)yb_addObject:(id)object {
    if (!object || [object isKindOfClass:[NSNull class]]) {
        [self yb_addObject:yb_defaultObject];
    } else {
        [self yb_addObject:object];
    }
}

@end
