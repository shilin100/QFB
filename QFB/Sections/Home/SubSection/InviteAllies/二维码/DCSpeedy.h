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
 判断是否是金额
 */
+ (BOOL)isPrice:(NSString *) price;

/**
 获取当前几号
 */
+ (int)getCurrentNumberTime;

#pragma mark - 图片转base64编码
+ (NSString *)UIImageToBase64Str:(UIImage *) image;

#pragma mark - base64图片转编码
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

/**
 触动
 */
+ (UIImage *)dc_getQRCode:(NSString *)url size:(CGFloat)size;


/**
 获取当前控制器
 */
+ (UIViewController *)dc_getCurrentVC;

@end
