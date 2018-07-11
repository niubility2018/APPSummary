//
//  ZFJPermission.h
//  APPSummary
//
//  Created by xubojoy on 2018/7/11.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ZFJCheckDataRestricted = 0, //联网权限
    ZFJCheckLocation = 1, //检查定位权限
    ZFJCheckAddressBook = 2, //检查通讯录权限
    ZFJCheckCalendars = 3, //检查日历权限
    ZFJCheckReminders = 4, //备忘录权限
    ZFJCheckPhotoLibrary = 5, //检查相册权限
    ZFJCheckAudio = 6, //检查麦克风权限
    ZFJCheckCamera = 7, //检查相机权限
    ZFJCheckNotification = 8 //检查通知权限
} ZFJCheckPermissionType;


typedef enum : NSUInteger {
    ZFJStatusDenied = 0,
    ZFJStatusRestricted = 1,
    ZFJStatusNotDetermined = 2,
    ZFJStatusAuthorized = 3,
    ZFJStatusUnknown = 4,
    ZFJStatusAuthorizedAlways = 5,
    ZFJStatusAuthorizedWhenInUse = 6
} ZFJCheckResultType;

@interface ZFJPermission : NSObject

@end
