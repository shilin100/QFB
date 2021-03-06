//
//  PublicData.h
//  QFB
//
//  Created by qqq on 2018/9/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, currentAPPMode) {
    model_normal    = 0,    // 默认模式
    model_online            // 上线
};

#import <Foundation/Foundation.h>

@interface PublicData : NSObject

@property (nonatomic, strong) QFBUserModel   *userModel;
@property (nonatomic, assign) currentAPPMode appModel;

+ (instancetype)sharePublic;


/**
 判断是否被别人登录
 */
+ (void)judgeUserByOnline:(void(^)(BOOL isOnLine, BOOL isSucceed))onLine;


/**
 判断当前模式
 */
+ (void)judgecurrentAPPMode:(void(^)(BOOL isSucceed))succeed;


/**
 跳转重新登录页面
 */
+ (void)logInAgain;

@end
