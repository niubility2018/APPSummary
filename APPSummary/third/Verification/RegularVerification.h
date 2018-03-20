//
//  RegularVerification.h
//  Ceshi
//
//  Created by 王晨辉 on 2018/3/1.
//  Copyright © 2018年 王晨辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularVerification : NSObject

#pragma 正则匹配手机号
+(BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+(BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+(BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+(BOOL)checkUserIdCard: (NSString *) idCard;
+ (BOOL) validateIdentityCard: (NSString *)value;
#pragma 正则匹配邮箱
+ (BOOL)checkUserEmail:(NSString *)email;
#pragma 正则匹配银行卡号
+ (BOOL)checkUserBankNumber:(NSString *)BankNumber;

@end
