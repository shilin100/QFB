//
//  QFBNetTool.m
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBNetTool.h"

@implementation QFBNetTool

+(UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView
{
    for (UIView *next = currentView ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark -RAC的GET 和POST请求


+ (RACSignal *)getWithURL:(NSString *)urlString withParamater:(NSDictionary *)paramter
{
    AFHTTPSessionManager *manager = [QFBNetTool sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    RACSubject *sub =[ RACSubject subject];
    [manager GET:urlString parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [sub sendNext:responseObject];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }

        [sub sendCompleted];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:ServerError];
        [sub sendCompleted];
    }];
    return sub;
}

+ (RACSignal *)postWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter
{
    AFHTTPSessionManager *manager = [QFBNetTool sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    RACSubject *sub =[ RACSubject subject];
    [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [sub sendNext:responseObject];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
        [sub sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:ServerError];
        [sub sendCompleted];
    }];
    
    return sub;
}


#pragma mark -基本的GET 和POST请求

static AFHTTPSessionManager * sharedManager ;
+ (AFHTTPSessionManager *)sharedHTTPSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [AFHTTPSessionManager manager];
        sharedManager.requestSerializer.timeoutInterval = 5;
    });
    return sharedManager;
}

//设置基本参数
+(NSMutableDictionary *)getBaseRequestParams{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

//    [params setObject:@"222" forKey:@"uid"];
//    [params setObject:@"111" forKey:@"token"];

    return params;
}


//*************************************基本的GET 和POST请求


+ (void)GetRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid
{
    NSMutableDictionary * params = [QFBNetTool getBaseRequestParams];
    [params addEntriesFromDictionary:dic];
    
    //    MMLog(@"GET请求链接 == %@ ",urlString);
    AFHTTPSessionManager *manager = [QFBNetTool sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
    }];
    
}


+ (void)GetRequestWithUrlString:(NSString *)urlString Succeed:(Succeed)succeed andFaild:(Failed)falid
{
    
    //    MMLog(@"GET请求链接 == %@ ",urlString);
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [QFBNetTool sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
    }];
}

+ (NSURLSessionDataTask *)PostRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid
{
    
    NSMutableDictionary * params = [QFBNetTool getBaseRequestParams];
    [params addEntriesFromDictionary:dic];
    
    //    MMLog(@"POST请求链接 == %@  %@",urlString,dic);
    AFHTTPSessionManager *manager = [QFBNetTool sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    NSURLSessionDataTask *urlSessionDataTask = [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
        [SVProgressHUD showErrorWithStatus:ServerError];
    }];
    
    return urlSessionDataTask;
}

+ (NSURLSessionDataTask *)ClearPostRequestWithUrlString:(NSString *)urlString withDic:(NSDictionary *)dic Succeed:(Succeed)succeed andFaild:(Failed)falid
{
    
    //    MMLog(@"POST请求链接 == %@  %@",urlString,dic);
    AFHTTPSessionManager *manager = [QFBNetTool sharedHTTPSessionManager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/plan",@"text/plain", nil];
    NSURLSessionDataTask *urlSessionDataTask = [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falid(error);
        [SVProgressHUD showErrorWithStatus:ServerError];
    }];
    
    return urlSessionDataTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(Progress)progress
                              success:(DownloadSucceed)success
                              failure:(Failed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    AFHTTPSessionManager *sessionManager = [QFBNetTool sharedHTTPSessionManager];
    __block NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //        返回文件位置的URL路径
        success(filePath);
        //保存的文件路径
        return [NSURL fileURLWithPath:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    
    return downloadTask;
}



@end
