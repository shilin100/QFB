//
//  ResetIdCardViewController.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "ResetIdCardViewController.h"

@interface ResetIdCardViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UIButton *_submitButton;
    __weak IBOutlet UITextField *_idCardTextField;
    __weak IBOutlet UITextField *_phoneTextField;
    __weak IBOutlet UITextField *_nameTextField;
}

@end

@implementation ResetIdCardViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"修改身份认证";
    [_submitButton setTitle:@"确认修改" forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
#pragma mark - UI
- (void)initUI
{
    _nameTextField.delegate = self;
    _phoneTextField.delegate = self;
    _idCardTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _idCardTextField.keyboardType = UIKeyboardTypeASCIICapable;
}
#pragma mark - service
- (void)confirmPerson
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"realName"] = _nameTextField.text;
    parameter[@"card"] = _idCardTextField.text;
    parameter[@"phone"] = _phoneTextField.text;
    parameter[@"blackNumber"] = @"";
    parameter[@"blackAccountName"] = @"";
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/updateCode.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"修改身份认证成功"];
            [kDefault setObject:self->_nameTextField.text  forKey:USER_REALNAMEk];
            [kDefault setObject:self->_idCardTextField.text  forKey:USER_IDCARDk];
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
