//
//  NSDate+Extension.h
//
//  Created by admin on 15/11/13.
//  Copyright © 2015年 JAJ. All rights reserved.
//


#import "NSDate+Extension.h"

@implementation NSDate (Extension)




+ (NSString *)dateFormatConversionWithDate:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setLocale:[NSLocale currentLocale]];
    //    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss zzz";
    
    // 当前时间
    NSDate *now = [NSDate date];
    //    HZXLog(@"now:%@",now);
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    if ([date isThisYear]) { // 今年
        if ([date isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date];
        } else if ([date isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:date];
    }
    
    return nil;
    
}


+ (NSString *)dateTimeWithDate:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setLocale:[NSLocale currentLocale]];
    //    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"HH:mm:ss"; //HH:mm:ss
    return [fmt stringFromDate:date];
}


+ (NSString *)dateHourAndMinuteWithDate:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setLocale:[NSLocale currentLocale]];
    //    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"HH:mm";
    return [fmt stringFromDate:date];
}


//秒数转换
+ (NSString *)dateFormatConversionWithTime:(NSString *)time
{
    NSDate *createDate = [[NSDate alloc] initWithTimeIntervalSince1970:[time integerValue]];
    
    CXLog(@"date:%@",createDate);
    return [self dateFormatConversionWithDate:createDate];
    
}


//获取年份
+ (NSString *)dateYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    //    NSInteger year=[components year];
    //    NSInteger month=[components month];
    //    NSInteger day=[components day];
    //    HZXLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",date,year,month,day);
    return [NSString stringWithFormat:@"%ld",[components year]];
}


//获取月份
+ (NSString *)dateMonthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [NSString stringWithFormat:@"%02ld",[components month]];
}


//获取日份
+ (NSString *)dateDayWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [NSString stringWithFormat:@"%02ld",[components day]];
}



+ (NSArray *)dateInfoWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSInteger weekday=[components weekday];
    CXLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld weekday=%ld",date,year,month,day,weekday);
    
    return @[
             [NSString stringWithFormat:@"%ld",[components year]],
             [NSString stringWithFormat:@"%ld",[components month]],
             [NSString stringWithFormat:@"%ld",[components day]],
             [NSString stringWithFormat:@"%ld",[components weekday]]
             ];
}



- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}


- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //时间差
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}


- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}



//字符串转日期
+ (NSDate *)dateWithString:(NSString *)dateStr
{
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";//设定时间格式,这里可以设置成自己需要的格式
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.timeZone = sourceTimeZone;
    return [fmt dateFromString:dateStr];
}

+ (NSString *)dateStrWithDate:(NSDate *)date
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";//设定时间格式,这里可以设置成自己需要的格式
    return [fmt stringFromDate:date];
}

+ (NSString *)dateNoFormatStrWithDate:(NSDate *)date
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    fmt.dateFormat = @"yyyyMMddHHmmss";//设定时间格式,这里可以设置成自己需要的格式
    return [fmt stringFromDate:date];
}


//[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
//[dateFormatter setLocale:[NSLocalecurrentLocale]];
//returnValue = [dateFormatter stringFromDate:date];

+ (NSString *)dateYMDStrWithDate:(NSDate *)date
{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [fmt setLocale:[NSLocale currentLocale]];
    fmt.dateFormat = @"yyyy-MM-dd";//设定时间格式,这里可以设置成自己需要的格式
    return [fmt stringFromDate:date];
}

/*
iOS 解决时间相差8小时问题

原因: 使用 NSDate *date = [NSDate date]; 获取的时间是标注的UTC时间,和北京时间相差8小时.将UTC时间转成当地的时间只需要设置  NSTimeZone *zone = [NSTimeZone systemTimeZone];
1.给NSDate设置时区
NSDate *date = [NSDate date];
NSTimeZone *zone = [NSTimeZone systemTimeZone];
NSInteger interval = [zone secondsFromGMTForDate: date];
NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
2.给NSDateFormatter设置时区
NSDateFormatter *formater = [[NSDateFormatter alloc]init];
[formater setDateFormat:@"yyyy年MM月dd日"];
[formater setTimeZone:[NSTimeZone localTimeZone]];
NSDate *date = [formater dateFromString:dateStr];


//方法一
- (void)tDate
{
    NSDate *date = [NSDatedate];
    NSTimeZone *zone = [NSTimeZonesystemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"%@", localeDate);
}
方法二
- (NSString*)dateAsString:(NSDate*)date
{
    // Create a single string expressing a mountain's climbed date, properly localized
    NSString *returnValue = @"";
    NSDateFormatter *dateFormatter = nil;
    if (date != nil) {
        if (dateFormatter ==nil) {
            dateFormatter = [[NSDateFormatteralloc]init];
        }
        //原文地址：http://blog.csdn.net/diyagoanyhacker/article/details/7096612
        //作者：禚来强
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setLocale:[NSLocalecurrentLocale]];
        returnValue = [dateFormatter stringFromDate:date];
    }
 */
@end
