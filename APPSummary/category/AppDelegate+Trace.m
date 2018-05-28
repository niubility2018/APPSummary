//
//  AppDelegate+Trace.m
//  APPSummary
//
//  Created by xubojoy on 2018/5/28.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "AppDelegate+Trace.h"
#import "TraceManager.h"
@implementation AppDelegate (Trace)

//为全局AppDelegate设计的分类：AOP编程方案
+ (void)setupLogging{
    NSDictionary *configDic = @{@"ViewController":@{@"des":@"show ViewController",},
                                @"Test1ViewController":@{@"des":@"show Test1ViewController",                                        @"TrackEvents":@[@{@"EventDes":@"click action1",
                                                                                                                                                       @"EventSelectorName":@"action1",                                                             @"block":^(id aspectInfo){
                                        NSLog(@"统计 Test1ViewController action1 点击事件");
                                        
                                    },},@{@"EventDes":@"click action2",                                                             @"EventSelectorName":@"action2",                                                             @"block":^(id aspectInfo){                                                                 NSLog(@"统计 Test1ViewController action2 点击事件");

                                    },}],},                                @"Test2ViewController":@{@"des":@"show Test2ViewController",

                                    }};
        [TraceManager setUpWithConfig:configDic];
}


@end

