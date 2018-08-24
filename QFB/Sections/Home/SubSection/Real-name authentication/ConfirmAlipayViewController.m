//
//  ConfirmAlipayViewController.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "ConfirmAlipayViewController.h"
#import <FBFramework/FBFramework.h>
#import "CertificationMessageViewController.h"

@interface ConfirmAlipayViewController ()


@end

@implementation ConfirmAlipayViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.title = @"支付宝账号绑定";
    if ([VerifyHelper isEmpty:[kDefault objectForKey:ALIPAY_ACCOUNTk]]) {
        _aliPayAccountTextField.text = @"";
        _nameTextField.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
#pragma mark - UI
- (void)initUI
{
    if (![VerifyHelper isEmpty:[kDefault objectForKey:USER_BAN]]) {
        _nameTextField.textColor = [CommonHelper colorWithHexString:@"#8A8A8A" alpha:1.];
        _aliPayAccountTextField.textColor = [CommonHelper colorWithHexString:@"#8A8A8A" alpha:1.];
        _nameTextField.userInteractionEnabled = NO;
        _aliPayAccountTextField.userInteractionEnabled = NO;
        _nameTextField.text = [kDefault objectForKey:USER_BAN];
        _aliPayAccountTextField.text = [kDefault objectForKey:USER_BN];
        [_submitButton setTitle:@"重置修改" forState:UIControlStateNormal];
    } else {
        _nameTextField.textColor = [CommonHelper colorWithHexString:@"#333333" alpha:1.];
        _aliPayAccountTextField.textColor = [CommonHelper colorWithHexString:@"#333333" alpha:1.];
        _nameTextField.userInteractionEnabled = YES;
        _aliPayAccountTextField.userInteractionEnabled = YES;
        _nameTextField.text = @"";
        _aliPayAccountTextField.text = @"";
        [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    }
}

#pragma mark - service
- (void)submitInfo
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"name"] = _nameTextField.text;
    parameter[@"account"] = _aliPayAccountTextField.text;
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/Verifiedbank.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"支付宝绑定成功"];
            [kDefault setObject:self->_nameTextField.text  forKey:USER_BAN];
            [kDefault setObject:self->_aliPayAccountTextField.text  forKey:USER_BN];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {
        
    }];
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

- (IBAction)submitButtonClicked:(id)sender {
    [self resignResponder];
    if ([_submitButton.titleLabel.text isEqualToString:@"重置修改"]) {
        //[self enterCertificationMessageViewControllerWithTitle:@"支付宝账号修改"];
        CertificationMessageViewController * c_vc = [[CertificationMessageViewController alloc] init];
        c_vc.titleString = @"支付宝账号修改";
        [self.navigationController pushViewController:c_vc animated:YES];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self submitInfo];
    }
}
- (void)resignResponder
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
