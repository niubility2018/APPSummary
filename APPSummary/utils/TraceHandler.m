//
//  TraceHandler.m
//  APPSummary
//
//  Created by xubojoy on 2018/5/28.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "TraceHandler.h"

@implementation TraceHandler

+ (void)statisticsWithEventName:(NSString *)eventName{
    NSLog(@"-----> %@",eventName);
}

@end
