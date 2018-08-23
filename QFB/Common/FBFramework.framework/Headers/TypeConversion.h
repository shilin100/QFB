//
//  TypeConversion.h
//  FlowCircle
//
//  Created by BoFeng on 15/1/13.
//  Copyright (c) 2015年 BoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TypeConversion : NSObject

/**
 将字符串转化成为字节类型

 @param aString 待转化的字符串
 @return 转化后的字节类型
 */
+ (NSData *)dataWithString:(NSString *)aString;

/**
 将字节类型转化成为字符串

 @param aData 待转化的字节类型
 @return 转化后的字符串
 */
+ (NSString *)stringWithData:(NSData *)aData;

/**
 将data类型转化为16进制的字符串

 @param sender 待转换的data
 @return 十六进制的字符串
 */
+ (NSString*)stringWithHexBytes2:(NSData *)sender;

/**
 将16进制的字符串转化为data

 @param hexString 16进制的字符串
 @return NSData对象
 */
+ (NSData*)dataWithHexBytesString:(NSString*)hexString;

/**
 将字节类型数据转化成16进制的字符串

 @param bytes 字节类型数据
 @return 16进制字符串
 */
+ (NSString *)parseByte2HexString:(Byte *)bytes;

/**
 将字节类型数组转化为16进制的字符串

 @param bytes 字节类型数组
 @return 16进制字符串
 */
+ (NSString *)parseByteArray2HexString:(Byte[])bytes;

/**
 将字典转化为json字符串

 @param dictionary 字典
 @return json字符串
 */
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

/**
 将数组转化为json字符串

 @param array 数组
 @return json字符串
 */
+(NSString *) jsonStringWithArray:(NSArray *)array;

/**
 将普通字符串转化为json字符串

 @param string 普通字符串
 @return json字符串
 */
+(NSString *) jsonStringWithString:(NSString *) string;

/**
 *	@brief	将字符串，字典，数组转化为json字符串
 *
 *	@return	json字符串
 */

/**
 将字符串，字典，数组转化为json字符串

 @param object NSArray,NSDictionary,NSString对象
 @return json字符串
 */
+(NSString *) jsonStringWithObject:(id) object;

/**
 设置字符串行间距

 @param string 传入的字符串
 @param textAligment 显示格式
 @param lineSpace 行间距
 @return 返回NSAttributedString
 */
+(NSAttributedString *)getAttributedStringWithString:(NSString *)string textAligment:(NSTextAlignment)textAligment font:(CGFloat)font lineSpace:(CGFloat)lineSpace;
@end
