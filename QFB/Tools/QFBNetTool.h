//
//  QFBNetTool.h
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Succeed)(NSDictionary * responseObject);
typedef void(^Failed)(NSError *error);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^Progress)(NSProgress *progress);
//下载成功
typedef void(^DownloadSucceed)(NSString * filePath);

@interface QFBNetTool : NSObject


//获取视图所属的控制器
+(UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView;

//下载文件并缓存
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(Progress)progress
                              success:(DownloadSucceed)success
                              failure:(Failed)failure;

//post请求
+ (NSURLSessionDataTask *)PostRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid;

//无额外参数post
+ (NSURLSessionDataTask *)ClearPostRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid;

//无参请求
+ (void)GetRequestWithUrlString:(NSString *)urlString Succeed:(Succeed)succeed andFaild:(Failed)falid;

//带参请求
+ (void)GetRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid;


@end
