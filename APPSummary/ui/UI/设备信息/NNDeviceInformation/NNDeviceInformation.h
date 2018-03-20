//
//  NNDeviceInformation.h
//  NNDeviceInformation
//
//  Created by 刘朋坤 on 17/4/7.
//  Copyright © 2017年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNDeviceInformation : NSObject
/// 屏幕宽度
+ (CGFloat)getDeviceScreenWidth;

/// 屏幕高度
+ (CGFloat)getDeviceScreenHeight;

/**
 获取设备分辨率
 */
+ (NSString *)getDevice_Resolution;

/// 获取设备版本号
+ (NSString *)getDeviceName;

/// 获取iPhone名称
+ (NSString *)getiPhoneName;

/// 获取app版本号
+ (NSString *)getAPPVerion;

/// 获取电池电量
+ (CGFloat)getBatteryLevel;

/// 当前系统名称
+ (NSString *)getSystemName;

/// 当前系统版本号
+ (NSString *)getSystemVersion;

/// 通用唯一识别码UUID
//+ (NSString *)getUUID;
+ (NSString*)getDeviceUUID;

/// 获取当前设备IP
+ (NSString *)getDeviceIPAdress;


+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/// 获取总内存大小
+ (long long)getTotalMemorySize;

/// 获取当前可用内存
+ (long long)getAvailableMemorySize;

/// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel;

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState;

/// 获取当前语言
+ (NSString *)getDeviceLanguage;

/**
 *  method  获取设备IDFA
 *  @return 设备IDFA
 */
+(NSString *)dy_getDeviceIDFA;

/**
 *  method  获取设备IDFV
 *  @return 设备IDFV
 */
+(NSString *)dy_getDeviceIDFV;

/**
 *  method  获取设备IMEI
 *  @return 设备IMEI
 */
+(NSString*)dy_getDeviceIMEI;

/**
 *  method  获取设备MAC
 *  @return 设备MAC
 */
+(NSString*)dy_getDeviceMAC;

/**
 *  method  获取设备UUID
 *  @return 设备UUID
 */
+(NSString*)dy_getDeviceUUID;

/**
 *  method  获取设备UDID
 *  @return 设备UDID
 */
+(NSString*)dy_getDeviceUDID;




@end
