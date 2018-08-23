//
//  CommonHelper.h
//  FlowCircle
//
//  Created by BoFeng on 15/1/21.
//  Copyright (c) 2015年 BoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CommonHelper : NSObject

/**
 发送一个通知

 @param notificationName 通知名
 @param userInfo 透传消息
 */
+ (void)postNotificationWithNotificationName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;


/**
 十六进制颜色转换为UIColor

 @param color 16进制颜色值
 @param alpha 透明度
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
