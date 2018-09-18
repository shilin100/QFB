//
//  QFBRegisterViewController.m
//  QFB
//
//  Created by qqq on 2018/8/9.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBRegisterViewController.h"
#import "QFBRegisterStepTwoViewController.h"
#import "QFBRegisterStepViewController.h"

@interface QFBRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *recommandTextField;

@end

@implementation QFBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"立即注册";
    
}
- (IBAction)nextBtnAction:(id)sender {
    if (_recommandTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入推荐码"];
        return;
    }
    
    [self requestVerifyRecommandCode];
    
}

-(void)requestVerifyRecommandCode{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"tjm"] = self.recommandTextField.text;
    parameter[@"oBrandId"] = O_BRAND_ID;

    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/tgmyz.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            if (!IS_OBJECT_EMPTY([responseObject objectForKey:@"data"])) {
//                QFBRegisterStepTwoViewController * vc = [QFBRegisterStepTwoViewController new];
                QFBRegisterStepViewController *vc = [[QFBRegisterStepViewController alloc] init];
                vc.parentId = responseObject[@"data"][@"parentId"];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"推荐码有误"];
            }

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
