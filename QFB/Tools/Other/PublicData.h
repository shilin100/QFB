//
//  PublicData.h
//  QFB
//
//  Created by qqq on 2018/9/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicData : NSObject

@property (nonatomic, strong) QFBUserModel *userModel;

+ (instancetype)sharePublic;


/**
 判断是否被别人登录
 */
+ (void)judgeUserByOnline:(void(^)(BOOL isOnLine, BOOL isSucceed))onLine;


/**
 跳转重新登录页面
 */
+ (void)logInAgain;

@end
