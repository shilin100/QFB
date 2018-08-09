//
//  QFBLoginViewModel.m
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBLoginViewModel.h"

@implementation QFBLoginViewModel


- (RACSignal *)loginSignal {

    return [RACSignal createSignal:^RACDisposable * (id subscriber) {
        if (self.userName.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
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


        [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"url"] withDic:parameter Succeed:^(NSDictionary *responseObject) {
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
        
        
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [self loginSignal];
        }];
        
    }
    return self;
}


@end
