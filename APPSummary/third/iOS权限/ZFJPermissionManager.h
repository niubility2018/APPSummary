//
//  ZFJPermissionManager.h
//  FingerprintUnlock.git
//
//  Created by ZFJ on 2018/7/5.
//  Copyright © 2018年 张福杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFJPermission.h"

@interface ZFJPermissionManager : NSObject


/**
 检查APP权限

 @param permissionType 要检查的权限类型
 @param completed 结果回调(FIRST:6 2 2 2 2 2 2 2 0)
 */
- (void)checkUpAPPPermission:(ZFJCheckPermissionType)permissionType completed:(void(^)(ZFJCheckResultType authStatus))completed;

/**
 请求权限

 @param permissionType 要请求的权限类型
 @param completed 结果回调
 */
- (void)requestAccessPermission:(ZFJCheckPermissionType)permissionType completed:(void(^)(BOOL isScu))completed;

/**
 跳转到设置APP页面
 */
- (void)jumpToAPPSetting;

/**
 用户拒绝访问权限,我们需要提醒用户打开访问开关

 @param meg 提示文字
 */
- (void)showStatusDeniedMeg:(NSString *)meg;




@end
