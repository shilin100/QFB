//
//  PublicData.m
//  QFB
//
//  Created by qqq on 2018/9/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "PublicData.h"
#import "QFBLoginViewController.h"

@implementation PublicData

@synthesize userModel = _userModel;

+ (instancetype)sharePublic
{
    static PublicData *public;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        public = [[PublicData alloc] init];
    });
    return public;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setUserModel:(QFBUserModel *)userModel
{
    _userModel = userModel;
    [NSKeyedArchiver archiveRootObject:userModel toFile:[PublicData getTheFilePath]];
}

- (QFBUserModel *)userModel
{
    if (_userModel == nil) {
        _userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[PublicData getTheFilePath]];
    }
    return _userModel;
}

+ (NSString *)getTheFilePath
{
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"userModel.data"];
    return file;
}

+ (void)judgeUserByOnline:(void(^)(BOOL isOnLine, BOOL isSucceed))onLine
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    dic[@"clientid"]  = [QFBTool getUUID];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/getUserByOnline.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        NSString *str = responseObject[@"msg"]; // 0 重新登录
        if ([@"0" isEqualToString:str]) {
            onLine(YES, YES);
        }else{
            onLine(NO, YES);
        }
    } andFaild:^(NSError *error) {
        onLine(NO, NO);
    }];
}

+ (void)logInAgain
{
    NSString * username = [kDefault objectForKey:USERNAMEk];
    NSString * psw = [kDefault objectForKey:PASSWORDk];
    BOOL isFirstTouch = [kDefault boolForKey:IS_FIRST_TOUCH];
    NSDictionary * dict = [kDefault dictionaryRepresentation];
    for (id key in dict) {
        [kDefault removeObjectForKey:key];
    }
    [kDefault synchronize];
    [kDefault setObject:username forKey:USERNAMEk];
    [kDefault setObject:psw forKey:PASSWORDk];
    [kDefault setBool:isFirstTouch forKey:IS_FIRST_TOUCH];
    QFBLoginViewController *vc = [[QFBLoginViewController alloc] init];
    QFBBaseNaviViewController * loginNav = [[QFBBaseNaviViewController alloc] initWithRootViewController:vc];
    APPLication.keyWindow.rootViewController = loginNav;
}

@end







