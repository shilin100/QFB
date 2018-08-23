//
//  VerifyHelper.h
//  onestong
//
//  Created by BoFeng on 15-9-23.
//  Copyright (c) 2015年 冯搏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+LJSeprator.h"

@interface VerifyHelper : NSObject

/**
 验证是否为空

 @param field 待验证字符串
 @return 空：YES， 否则：No
 */
+(BOOL)isEmpty:(NSString *)field;

/**
 验证邮箱号

 @param email 输入的地址
 @return yes:是邮箱地址
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 判断是否手机号码

 @param phoneStr 输入字符串
 @return yes : 是
 */
+ (BOOL)isPhoneNumInputString:(NSString *)phoneStr;

/**
 检查网络

 @return 有网：YES
 */
+ (BOOL)checkHasNetWork;

/**
 判断一个对象是否为nil

 @param obj 传入的对象
 @return 如果是nil返回yes,否则为No
 */
+ (BOOL)isNull:(id)obj;
/**
 判断字符串是否包含非法字符

 @param string 传入的字符串
 @return 包含: YES
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
