//
//  TimeHelper.h
//  Transaction
//
//  Created by 冯搏 on 14-12-25.
//  Copyright (c) 2014年 冯搏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject

/**
 获取当前时间的日期详细

 @return 返回当前日期的详细信息
 */
+ (NSDateComponents *)getDateComponents;

/**
 convert NSDate to NSDateComponents

 @param date 日期
 @return NSDateComponents 对象
 */
+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;

/**
 convert time in long long type to NSDateComponents

 @param time 时间
 @return NSDateComponents类
 */
+ (NSDateComponents *)convertTimeToDateComponents:(long long)time;

/**
 convert NSDate to long long type

 @param date 日期
 @return 时间戳
 */
+ (long long)convertDateToSecondTime:(NSDate *)date;

/**
 convert long long to NSDate type

 @param time 时间戳
 @return 日期
 */
+ (NSDate *)convertSecondsToDate:(long long)time;

/**
 自当前日期开始获取时间列表，1个页面对应10个日期

 @param page 第xx页，从0开始
 @return 返回一个日期的数组
 */
+ (NSMutableArray *)getNextPageDays:(int)page;

/**
 根据日期获取当日是星期几

 @param date 日期
 @return 所在周的星期数
 */
+ (NSString *)getWeekDayInweekWithDate:(NSDate *)date;

/**
 获取当前日期所在周的周一

 @param date 要查询的日期
 @return 该日期所在周的周一
 */
+ (NSDate *)getBeginDateInWeekWith:(NSDate *)date;

/**
 获取当前日期的前一天

 @param date 要查询的日期
 @return 该日期的前一天
 */
+ (NSDate *)getYesterDay:(NSDate *)date;

/**
 获取当前日期所在周的周日

 @param date 要查询的日期
 @return 该日期所在周的周日
 */
+ (NSDate *)getEndDateInWeekWithDate:(NSDate *)date;

/**
 获取当前日期所在周上周的周日

 @param date 要查询的日期
 @return 该日期所在周上周的周日
 */
+ (NSDate *)getlastWeekDayDateWithDate:(NSDate *)date;

/**
 获取当前日期所在周上周的周一

 @param date 要查询的日期
 @return 该日期所在周上周的周一
 */
+ (NSDate *)getlastFirstDayDateWithDate:(NSDate *)date;

/**
 返回当前日期所在月的第一天

 @param date 当前日期
 @return 日期
 */
+ (NSDate *)getFirstDayDateInCurrentDateMonthWithDate:(NSDate *)date;

/**
 返回当前日期所在月的最后一天

 @param date 当前日期
 @return 日期
 */
+ (NSDate *)getEndDayDateInCurrentDateMonthWithDate:(NSDate *)date;

/**
 返回当前日期所在月的上月的最后一天

 @param date 当前日期
 @return 日期
 */
+ (NSDate *)getEndDayDateInLastMonthOfDateWithDate:(NSDate *)date;

/**
 返回当前日期所在月的上月的第一天

 @param date 当前日期
 @return 日期
 */
+ (NSDate *)getFirstDayDateInLastMonthOfDateWithDate:(NSDate *)date;

/**
 返回当前日期的年-月-日

 @param date 当前日期
 @return @"年-月-日"
 */
+ (NSString *)getYearMonthDayWithDate:(NSDate *)date;

/**
 返回当前日期的XXXX年XX月XX日

 @param date 当前日期
 @return XXXX年XX月XX日
 */
+ (NSString *)getYearMonthDayWithDateInChinese:(NSDate *)date;

/**
 字符串转换成日期 目前只支持xxxx-xx-xx格式

 @param str 日期字符串
 @return date
 */
+ (NSDate *)dateFromString:(NSString *)str;

/**
 将字符串转换成nsdate

 @param str 待转换的字符串
 @param format 转换格式
 @return nsdate
 */
+ (NSDate *)timeFromString:(NSString *)str andFormat:(NSString *)format;

/**
 将日期按照指定的格式转化成字符串

 @param date 日期
 @param format 格式
 @return 转化好的字符串
 */
+ (NSString *)getDateStringWithDate:(NSDate *)date andFormat:(NSString *)format;


/**
 获取当前日期的后面的第day天

 @param date 当前日期
 @param day 从当前日期开始算起（比如当前日期的后一天day为1，前一天day为-1）
 @return 日期
 */
+ (NSDate *)getDateSinceDate:(NSDate *)date day:(NSInteger)day;


/**
 返回当前日期所在周的周日

 @param date 当前日期
 @return 日期
 */
+ (NSDate *)getFirstDayInWeekWithDate:(NSDate *)date;

/**
 返回当前日期所在周的周六

 @param date 当前日期
 @return 日期
 */
+ (NSDate *)getLastDayInWeekWithDate:(NSDate *)date;
@end
