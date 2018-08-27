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

    if (self.userName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名或手机号"];
        return [RACSignal empty];

    }
    if (self.password.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码最少6位"];
        return [RACSignal empty];
    }
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.userName;
    parameter[@"pwd"] = self.password;
    parameter[@"oBrandId"] = O_BRAND_ID;
    parameter[@"clientid"] = [QFBTool getUUID];

    RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/user/login.action",BASEURL] withParamater:parameter];
    [signal subscribeNext:^(id  _Nullable x) {
        NSDictionary * data = x[@"data"];
        
        [kDefault setObject:self.userName forKey:USERNAMEk];
        [kDefault setObject:self.password forKey:PASSWORDk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"userPicture"]) forKey:USER_HEAD_IMGk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"nickName"])  forKey:NICK_NAMEk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"id"])  forKey:USER_IDk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"roleId"])  forKey:ROLE_IDk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"blackAccountName"])  forKey:ALIPAY_NAMEk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"blackNum"])  forKey:ALIPAY_ACCOUNTk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"card"])  forKey:USER_IDCARDk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"realName"])  forKey:USER_REALNAMEk];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"phone"])  forKey:USER_PHONE];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"blackAccountName"])  forKey:USER_BAN];
        [kDefault setObject:OBJ_EMPTY_OR_OBJ(data[@"blackNum"])  forKey:USER_BN];
        [kDefault setBool:YES forKey:IS_LOGIN];
    }];
    return signal;
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
