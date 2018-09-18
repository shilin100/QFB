//
//  ShareSDKTool.h
//  QFB
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
//微信SDK头文件
#import "WXApi.h"
// UI
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface ShareSDKTool : NSObject

+ (void)initShareSDK;

+ (void)createShareImageUrlStr:(NSString *)imageUrlStr urlStr:(NSString *)urlstr title:(NSString *)title text:(NSString *)text block:(void(^)(BOOL isSuccess))Success;

@end
