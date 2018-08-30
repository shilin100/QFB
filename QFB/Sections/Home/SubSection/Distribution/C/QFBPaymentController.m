//
//  QFBPaymentController.m
//  QFB
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBPaymentController.h"
#import "QFBUserModel.h"

@interface QFBPaymentController ()

@property (weak, nonatomic) IBOutlet UILabel *label_balance;
@property (weak, nonatomic) IBOutlet UIButton *button_zfb;
@property (weak, nonatomic) IBOutlet UIButton *button_ye;
@property (nonatomic, assign) double balance;      // 可用余额

@end

@implementation QFBPaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付";
    _button_zfb.selected = YES;
    _button_ye.selected = NO;
    [self getBalanceMoney];
}

#pragma mark - service
- (void)getBalanceMoney
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/findUserById.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        QFBUserModel *model = [QFBUserModel mj_objectWithKeyValues:responseObject[@"data"]];
        weakSelf.label_balance.text = [NSString stringWithFormat:@"可用金额￥%g",model.remarks];
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络出错"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}

- (IBAction)pressZFB:(id)sender {
    _button_zfb.selected = YES;
    _button_ye.selected = NO;
}

- (IBAction)pressYE:(id)sender {
    _button_zfb.selected = NO;
    _button_ye.selected = YES;
}

- (IBAction)pressSure:(id)sender {
    if (_button_zfb.isSelected) {   //  使用支付宝
        
    }else{                          //  使用余额
        if (self.balance < self.amountOfPayment) {
            [SVProgressHUD showInfoWithStatus:@"您的余额不足,请选择别的支付方式"];
            [SVProgressHUD dismissWithDelay:1.0];
            return ;
        }
        WEAKSELF;
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
        dic[@"roleId"]    = [kDefault objectForKey:ROLE_IDk];
        dic[@"price"]     = [NSNumber numberWithDouble:self.amountOfPayment];
        [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/updateUserPrice.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
            
            
            
        } andFaild:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:@"网络出错"];
            [SVProgressHUD dismissWithDelay:0.5];
        }];
    }
}

@end


//@{@"userId":userId,@"roleId":roleId,@"price":price};



