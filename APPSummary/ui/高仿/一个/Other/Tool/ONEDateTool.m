//
//  ONEDateTool.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/4.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "ONEDateTool.h"
#import "ONEMainTabBarController.h"
#import "ONEHomeWeatherItem.h"
#import "NSString+ONEComponents.h"

static ONEDateTool *_instance;

@implementation ONEDateTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ONEDateTool alloc] init];
    });
    return _instance;
}

- (NSString *)currentDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *currentDate = [formatter dateFromString:self.dateOriginStr];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    return currentDateString;
}

- (NSString *)getDateStringFromCurrentDateWihtDateInterval:(NSInteger)dateInterval {
    NSDate *newDate = [self getDateFromCurrentDateWithDateInterval:dateInterval];
    return [NSString getDateStringWithDate:newDate];
}

- (NSDate *)getDateFromCurrentDateWithDateInterval:(NSInteger)dateInterval {
    NSDate *currentDate = [self.currentDateString getDate];
    NSTimeInterval intervalInSeconds = dateInterval * 24.0 * 60 * 60;
    NSDate *newDate = [currentDate dateByAddingTimeInterval:-intervalInSeconds];
    return newDate;
}

- (NSInteger)getDateIntervalFromCurrentDateWithDateString:(NSString *)dateString {
    NSDate *newDate = [dateString getDate];
    NSTimeInterval timeInterval = [newDate timeIntervalSinceDate:[self.currentDateString getDate]];
    NSInteger dateInterval = timeInterval / 24.0 / 60 / 60;
    return dateInterval;
}

- (NSString *)yesterdayDateStr {
    return [self getDateStringFromCurrentDateWihtDateInterval:1];
}

- (NSString *)getCommentDateStringWithOriginalDateString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm";
    return [formatter stringFromDate:date];
}

- (NSString *)getFeedsRequestDateStringWithOriginalDateString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = @"yyyy-MM";
    return [formatter stringFromDate:date];
}

- (NSString *)getFeedsDateStringWithOriginalDateString:(NSString *)originalDateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:originalDateString];
    formatter.dateFormat = @"yyyy / MM / dd";
    return [formatter stringFromDate:date];
}

- (NSString *)getNextMonthDateStringWithDateString:(NSString *)dateString {
    NSDateComponents *components = [dateString getComponents];
    if (components.month == 12) {
        return [NSString stringWithFormat:@"%ld-01",components.year + 1];
    } else {
        return [NSString stringWithFormat:@"%ld-%02ld",components.year, components.month + 1];
    }
}

- (NSString *)getLastMonthDateStringWithDateString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:dateString];
    NSDate *lastMonthDate = [date dateByAddingTimeInterval:-24*60*60];
    formatter.dateFormat = @"yyyy-MM";
    return [formatter stringFromDate:lastMonthDate];
}

@end
