//
//  DateUtils.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (void)load{
    // 1、获取当前时间
    NSDate *now = [NSDate date];
    NSDateFormatter *nowFormate = [[NSDateFormatter alloc] init];
    nowFormate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowTime = [nowFormate stringFromDate:now];
    NSLog(@"nowTime = %@",nowTime);
    // 2、拿现在的时间和过去时间或者将来时间对比，计算出相差多少天，多少年，多少秒等等；
    NSDate *beforTime = [nowFormate dateFromString:@"2014-06-14 19:25:00"];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //世纪
    NSInteger era  = kCFCalendarUnitEra;
    //年
    NSInteger year = kCFCalendarUnitYear;
    //月
    NSInteger month = kCFCalendarUnitMonth;
    //小时
    NSInteger hour = kCFCalendarUnitHour;
    //分钟
    NSInteger minute = kCFCalendarUnitMinute;
    //秒
    NSInteger second = kCFCalendarUnitSecond;
    
    NSDateComponents *compsEra = [calender components:era fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsYear = [calender components:year fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsMonth = [calender components:month fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsHour = [calender components:hour fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsMinute = [calender components:minute fromDate:beforTime toDate:now options:0];
    NSDateComponents *compsSecond = [calender components:second fromDate:beforTime toDate:now options:0];
    
    NSLog(@"相差世纪个数 = %ld",[compsEra era]);
    NSLog(@"相差年个数 = %ld",[compsYear year]);
    NSLog(@"相差月个数 = %ld",[compsMonth month]);
    NSLog(@"相差小时个数 = %ld",[compsHour hour]);
    NSLog(@"相差分钟个数 = %ld",[compsMinute minute]);
    NSLog(@"相差秒个数 = %ld",[compsSecond second]);
    
    // 3、获取时间戳（相对于1970年）
    CGFloat timestamp = now.timeIntervalSince1970;
    NSLog(@"距离1970年有多少秒 = %f",timestamp);
    
    // 4、计算距离现在有多少秒
    CGFloat sinceNow = beforTime.timeIntervalSinceNow;
    NSLog(@"距离现在有多少秒 = %f",fabs(sinceNow));
}

+ (NSString *)currentCycleEndTimeStrWithType:(EndTimeType)type {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    switch (type) {
        case EndTimeTypeDay:
            [components setDay:([components day]+1)];
            break;
        case EndTimeTypeWeek:
            [components setDay:([components day]+7)];
            break;
        case EndTimeTypeMonth:
            [components setMonth:([components month]+1)];
            break;
        default:
            break;
    }
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay format:(NSString *)format {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *dateA = [dateFormat dateFromString:oneDay];
    NSDate *dateB = [dateFormat dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}


@end
