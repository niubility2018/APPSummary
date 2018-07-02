//
//  OtherDetailViewController.h
//  APPSummary
//
//  Created by xubojoy on 2018/7/2.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BasicInfoType) {
    BasicInfoTypeHardWare,
    BasicInfoTypeBattery,
    BasicInfoTypeIpAddress,
    BasicInfoTypeCPU,
    BasicInfoTypeDisk,
};
@interface OtherDetailViewController : UIViewController
- (instancetype)initWithType:(BasicInfoType)type;
@end
