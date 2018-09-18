//
//  CertificationMessageViewController.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "CertificationMessageViewController.h"
#import <FBFramework/FBFramework.h>
#import "ResetAliPayAccountViewController.h"
#import "ResetIdCardViewController.h"

@interface CertificationMessageViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_codeTextField;
    __weak IBOutlet UITextField *_phoneTextField;
    __weak IBOutlet UIButton *_codeButton;
    NSInteger _staticSecNum;
    NSTimer *_timer;
    UILabel *_timerLabel;
}

@end

@implementation CertificationMessageViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title = self.titleString;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_timerLabel removeFromSuperview];
    _timerLabel = nil;
    [_timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeTextField.delegate = self;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _codeTextField.returnKeyType = UIReturnKeyDone;
}
#pragma mark - UI
- (void)timerForVerCodeClick
{
    //    _timerLabel = [UILabel new];
    _timerLabel = [[UILabel alloc] initWithFrame:_codeButton.bounds];
    _timerLabel.backgroundColor = [UIColor clearColor];
    _timerLabel.font = [UIFont systemFontOfSize:14.f];
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.textColor = [CommonHelper colorWithHexString:@"#eb9125" alpha:1];
    _codeButton.userInteractionEnabled = NO;
    _codeButton.layer.borderWidth = 0;
    [_codeButton setTitle:nil forState:UIControlStateNormal];
    _timerLabel.text = [NSString stringWithFormat:@"%lds",(long)_staticSecNum];
    [_codeButton addSubview:_timerLabel];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(modifyVerCodeButton) userInfo:nil repeats:YES];
}
- (void)modifyVerCodeButton
{
    _staticSecNum -= 1;
    if (_staticSecNum <= 0) {
        [self timerInvalidate];
        return;
    }
    [self timerFired];
}

- (void)timerInvalidate
{
    [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _codeButton.userInteractionEnabled = YES;
    [_codeButton setTitleColor:[CommonHelper colorWithHexString:@"##3F84C5" alpha:1.] forState:UIControlStateNormal];
    [_codeButton setBackgroundColor:[UIColor whiteColor]];
    [_timerLabel removeFromSuperview];
    _timerLabel = nil;
    [_timer invalidate];
}

- (void)timerFired
{
    _timerLabel.text = [NSString stringWithFormat:@"%lds",(long)_staticSecNum];
}
#pragma mark - method

- (IBAction)codeButtonClicked:(id)sender
{
    [self resignResponder];
    if (![self canGetCode]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getMessageCode];
}

- (IBAction)submitButtonClicked:(id)sender
{
    if ([_titleString isEqualToString:@"支付宝账号修改"]) {
        //[self enterResetAliPayAccountViewController];
        ResetAliPayAccountViewController * r_vc = [[ResetAliPayAccountViewController alloc] init];
        [self.navigationController pushViewController:r_vc animated:YES];
    } else {
        //[self enterResetIdCardViewController];
        ResetIdCardViewController * r_vc = [[ResetIdCardViewController alloc] init];
        [self.navigationController pushViewController:r_vc animated:YES];
    }
}
#pragma mark - service
- (void)getMessageCode
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = _phoneTextField.text;
    parameter[@"oBrandId"] = O_BRAND_ID;
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/sendyzm.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"短信发送成功"];
            self->_staticSecNum = 60;
            [self timerForVerCodeClick];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {
        
    }];
}
- (void)resignResponder
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (BOOL)canGetCode
{
    if ([VerifyHelper isEmpty:_phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return NO;
    }
    if (![self validateMobile:_phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式不正确"];
        return NO;
    }
    return YES;
}
- (BOOL)validateMobile:(NSString*)mobile

{
    NSString*phoneRegex =@"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate*phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    BOOL sss;
    //    sss = [phoneTest evaluateWithObject:mobile];
    return[phoneTest evaluateWithObject:mobile];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
