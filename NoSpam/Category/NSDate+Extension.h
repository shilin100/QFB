//
//  NSDate+Extension.h
//
//  Created by admin on 15/11/13.
//  Copyright © 2015年 JAJ. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;



+ (NSString *)dateFormatConversionWithTime:(NSString *)time;
+ (NSString *)dateFormatConversionWithDate:(NSDate *)date;

//获取月份
+ (NSString *)dateYearWithDate:(NSDate *)date;

//获取月份
+ (NSString *)dateMonthWithDate:(NSDate *)date;

//获取日
+ (NSString *)dateDayWithDate:(NSDate *)date;


//得到时间（时分秒）
+ (NSString *)dateTimeWithDate:(NSDate *)date;

//小时 分钟
+ (NSString *)dateHourAndMinuteWithDate:(NSDate *)date;

//直接返回数组（年、月、日、星期几）
+ (NSArray *)dateInfoWithDate:(NSDate *)date;


//字符串转日期
+ (NSDate *)dateWithString:(NSString *)dateStr;

+ (NSString *)dateStrWithDate:(NSDate *)date;
+ (NSString *)dateNoFormatStrWithDate:(NSDate *)date;

//格式yyyy-MM-dd
+ (NSString *)dateYMDStrWithDate:(NSDate *)date;

@end
