//
//  ShareSDKTool.m
//  QFB
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "ShareSDKTool.h"

@implementation ShareSDKTool

+ (void)createShareImageUrlStr:(NSString *)imageUrlStr urlStr:(NSString *)urlstr title:(NSString *)title text:(NSString *)text block:(void(^)(BOOL isSuccess))Success;
{
    //1、创建分享参数
    NSArray* imageArray = @[imageUrlStr];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:imageArray
                                            url:[NSURL URLWithString:urlstr]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    Success(YES);
                    break;
                }
                case SSDKResponseStateFail:
                {
                    Success(NO);
                    break;
                }
                default:
                    break;
            }
        }];
    }
}

+ (void)initShareSDK
{
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeWechat),
                                        ]
    onImport:^(SSDKPlatformType platformType){
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
    }
    onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeChat_App_Id
                                       appSecret:WeChat_App_Secret];
                break;
             default:
                break;
        }
    }];
}

@end
