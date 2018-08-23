//
//  ResetAliPayAccountViewController.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "ResetAliPayAccountViewController.h"
#import <FBFramework/FBFramework.h>

@interface ResetAliPayAccountViewController ()
{
    __weak IBOutlet UIButton *_submitButton;
    __weak IBOutlet UITextField *_nameTextField;
    __weak IBOutlet UITextField *_aliPayAccountTextField;
}

@end

@implementation ResetAliPayAccountViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"支付宝账号修改";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
#pragma mark - UI
- (void)initUI
{
    _nameTextField.text = @"";
    _aliPayAccountTextField.text = @"";
    
}
#pragma mark - method
- (IBAction)submitButtonClicked:(id)sender
{
    [self resignResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self submitInfo];
}
#pragma mark - service
- (void)submitInfo
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"realName"] = @"";
    parameter[@"card"] = @"";
    parameter[@"phone"] = @"";
    parameter[@"blackNumber"] = _aliPayAccountTextField.text;
    parameter[@"blackAccountName"] = _nameTextField.text;
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/updateCode.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"支付宝重新绑定成功"];
            [kDefault setObject:self->_aliPayAccountTextField.text  forKey:USER_BN];
            [kDefault setObject:self->_nameTextField.text  forKey:USER_BAN];
            //            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FB" bundle:nil];
            //            UIViewController *onLineCtrl = [storyboard instantiateViewControllerWithIdentifier:@"CertificationViewController"];
            //            UIViewController *target = nil;
            //            for (UIViewController * controller in self.navigationController.viewControllers) {
            //                //遍历
            //                if ([controller isKindOfClass:[onLineCtrl class]]) { //这里判断是否为你想要跳转的页面
            //                    target = controller;
            //                    if (target) {
            //                        [self.navigationController popToViewController:target animated:NO]; //跳转
            //                        return;
            //                    }
            //                }
            //            }
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
