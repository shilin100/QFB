//
//  DCSpeedy.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DCSpeedy : NSObject

/**
 获取当前时间 （以毫秒为单位）
 */
+ (NSString *)getNowTimestamp;

/**
 判断是否是金额
 */
+ (BOOL)isPrice:(NSString *) price;

/**
 获取当前几号
 */
+ (int)getCurrentNumberTime;

//获取当前月份
+ (int)getCurrentMonthTime;

#pragma mark - 图片转base64编码
+ (NSString *)UIImageToBase64Str:(UIImage *) image;

#pragma mark - base64图片转编码
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

/**
 获取二维码图片
 */
+ (UIImage *)dc_getQRCode:(NSString *)url size:(CGFloat)size;


/**
 获取当前控制器
 */
+ (UIViewController *)dc_getCurrentVC;

/**
 判断一个字符串是纯数字
 */
+ (BOOL)dc_getIsPureNum:(NSString *)text;

/**
 获取文字高度
 */
+ (CGFloat)dc_getSizeWithStr:(NSString *) str Width:(float)width Font:(float)fontSize;

/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)dc_messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize;

@end







