//
//  UIViewController+Trace.m
//  APPSummary
//
//  Created by xubojoy on 2018/5/28.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "UIViewController+Trace.h"
#import <objc/runtime.h>
#import "TraceHandler.h"
#import <Aspects.h>
@implementation UIViewController (Trace)

//为VC设计的分类：AOP编程方案
+ (void)load{
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id aspectInfo){
                                   NSString *className = NSStringFromClass([[aspectInfo instance] class]);;
                                   [TraceHandler statisticsWithEventName:className];
                               } error:nil];
}

//为VC设计的分类：运行时Method Swizzling方案
//+ (void)load{
//    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
//}
- (void)swizzled_viewDidAppear:(BOOL)animated{    // call original implementation
    [self swizzled_viewDidAppear:animated];    // Begin statistics Event
    [TraceHandler statisticsWithEventName:@"UIViewController"];
}

void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector){    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
