//
//  QFBLoginViewModel.m
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBLoginViewModel.h"

@implementation QFBLoginViewModel

- (RACSignal *)getBgImgSignal{
    
    return [RACSignal createSignal:^RACDisposable * (id subscriber) {
        
        NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
        parameter[@"oBrandId"] = O_BRAND_ID;
        
        [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/appDynamic/selectLoginLogo.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
            NSString *status;
            status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
            int code;
            if ([status isEqualToString:@"1"]) {
                code = Response_Success;
                [subscriber sendNext:responseObject];

            } else {
                [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试。"];
                code = 999;
            }
            [subscriber sendCompleted];
            
        } andFaild:^(NSError *error) {
            [subscriber sendCompleted];
        }];
        return nil;
    }];

}

- (RACSignal *)loginSignal {

    return [RACSignal createSignal:^RACDisposable * (id subscriber) {
        if (self.userName.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入用户名或手机号"];
            [subscriber sendCompleted];
            return nil;

        }
        if (self.password.length < 6) {
            [SVProgressHUD showErrorWithStatus:@"密码最少6位"];
            [subscriber sendCompleted];
            return nil;

        }
        
        NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
        parameter[@"phone"] = self.userName;
        parameter[@"password"] = self.password;


        [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/appDynamic/selectLoginLogo.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];

        } andFaild:^(NSError *error) {
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

-(instancetype)init
{
    if (self = [super init]) {
        
        RACSignal *userNameLengthSig = [RACObserve(self, userName)
                                        map:^id(NSString *value) {
                                            if (value.length >= 11)
                                                return @(YES);
                                            return @(NO);
                                        }];
        RACSignal *passwordLengthSig = [RACObserve(self, password)
                                        map:^id(NSString *value) {
                                            if (value.length >= 6) return @(YES);
                                            return @(NO);
                                        }];
        
        
        _loginBtnEnable = [RACSignal combineLatest:@[userNameLengthSig, passwordLengthSig] reduce:^id(NSNumber *userName, NSNumber *password){
            return @([userName boolValue] && [password boolValue]);
        }];
        
        
        _getBgImgCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
            parameter[@"oBrandId"] = O_BRAND_ID;
            
            RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/appDynamic/selectLoginLogo.action",BASEURL] withParamater:parameter];
            
            UIImageView * imgV = input;
            [signal subscribeNext:^(id  _Nullable x) {
                [imgV sd_setImageWithURL:[NSURL URLWithString:x[@"data"][@"imgUrl"]]];
            }];

            return [RACSignal empty];
        }];
        
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [self loginSignal];
        }];
        
    }
    return self;
}


@end
