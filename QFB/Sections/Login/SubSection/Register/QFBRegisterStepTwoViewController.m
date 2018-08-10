//
//  QFBRegisterStepTwoViewController.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBRegisterStepTwoViewController.h"

@interface QFBRegisterStepTwoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation QFBRegisterStepTwoViewController
{
    NSTimer * timer;
    NSString * forgetPswId;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * title;
    if (self.vcType == TYPE_FORGET_PSW) {
        title = @"忘记密码";
        [_registerBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        _phoneTextField.placeholder = @"请输入手机号码";
        _pswTextField.placeholder = @"请重新设置您的登陆密码";

    }else{
        title = @"立即注册";
    }
    self.navigationItem.title = title;
}
- (IBAction)verifyBtnAction:(id)sender {
    if (![RegularHelperUtil checkTelNumber:_phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    [timer invalidate];
    timer = nil;
    __block int i = 1;
    [self.verifyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.verifyBtn setTitle:@"60" forState:UIControlStateNormal];

    self.verifyBtn.userInteractionEnabled = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.verifyBtn setTitle:[NSString stringWithFormat:@"%ds",60 - i] forState:UIControlStateNormal];
        i++;
        if (i > 60) {
            [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.verifyBtn setTitleColor:HEXCOLOR(0x86BDF1) forState:UIControlStateNormal];
            self.verifyBtn.userInteractionEnabled = YES;
            [timer invalidate];
        }
    }];
    
    [self requestVerifyCode];
}
- (IBAction)registerBtnAction:(id)sender {
    if (![RegularHelperUtil checkTelNumber:_phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if (_verifyTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (_pswTextField.text.length < 8 || _pswTextField.text.length > 16 ) {
        [SVProgressHUD showErrorWithStatus:@"请正确输入8-16位密码"];
        return;
    }
    if (_vcType == TYPE_FORGET_PSW) {
        [self requestVerifyPhoneExist];
    }else{
        [self requestFinalAction];

    }
    
}

-(void)requestVerifyCode{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.phoneTextField.text;
    parameter[@"oBrandId"] = O_BRAND_ID;
    
    NSString * urlStr;
    if (self.vcType == TYPE_FORGET_PSW) {
        urlStr =[NSString stringWithFormat:@"%@/user/sendPwdYzm.action",BASEURL];
    }else{
        urlStr =[NSString stringWithFormat:@"%@/user/registerYzm.action",BASEURL];
    }
    
    
    [QFBNetTool PostRequestWithUrlString:urlStr withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {
        
    }];

}

-(void)requestFinalAction{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.phoneTextField.text;
    parameter[@"oBrandId"] = O_BRAND_ID;
    parameter[@"verificationCode"] = self.verifyTextField.text;
    parameter[@"pwd"] = self.pswTextField.text;


    NSString * urlStr;
    if (self.vcType == TYPE_FORGET_PSW) {
        urlStr =[NSString stringWithFormat:@"%@/user/updatePwd.action",BASEURL];
        parameter[@"id"] = forgetPswId;

    }else{
        urlStr =[NSString stringWithFormat:@"%@/user/toRegister.action",BASEURL];
        parameter[@"parentId"] = self.parentId;
    }

    
    [QFBNetTool PostRequestWithUrlString:urlStr withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:status];
        }
        
    } andFaild:^(NSError *error) {
        
    }];
    
}

-(void)requestVerifyPhoneExist{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = self.phoneTextField.text;
    parameter[@"oBrandId"] = O_BRAND_ID;
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/findByPhone.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            if (!IS_OBJECT_EMPTY(responseObject[@"data"])) {
                self->forgetPswId = responseObject[@"data"][@"id"];
                [self requestFinalAction];
            }else {
                [SVProgressHUD showErrorWithStatus:@"查询数据为空"];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:status];
        }
        
    } andFaild:^(NSError *error) {
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [timer invalidate];
    timer = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
