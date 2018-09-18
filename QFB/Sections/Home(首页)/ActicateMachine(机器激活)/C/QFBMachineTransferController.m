//
//  QFBMachineTransferController.m
//  QFB
//
//  Created by qqq on 2018/9/12.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMachineTransferController.h"
#import "QFBMachineTransUsersController.h"

@interface QFBMachineTransferController ()

@property (weak, nonatomic) IBOutlet UILabel *label_code;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_transferName;
@property (weak, nonatomic) IBOutlet UIImageView *image_user;
@property (weak, nonatomic) IBOutlet UIImageView *image_go;
@property (weak, nonatomic) IBOutlet UIButton *button_sure;

@property (nonatomic, strong) QFBUserModel *transferModel;
@property (nonatomic, strong) QFBNetWorkTool *myNetWork;

@end

@implementation QFBMachineTransferController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"机器转让";
    self.myNetWork = [[QFBNetWorkTool alloc] init];
    _button_sure.layer.cornerRadius = 5;
    _button_sure.hidden = YES;
    _label_transferName.hidden = YES;
    _label_code.text = [NSString stringWithFormat:@"%@   %@",_myMachineModel.reserve,_myMachineModel.psamCode];
    _label_name.text = [kDefault objectForKey:USER_REALNAMEk];
}


- (void)setTransferModel:(QFBUserModel *)transferModel
{
    _transferModel = transferModel;
    if (transferModel.realName.length > 0) {
        _label_transferName.text = transferModel.realName;
    }else{
        _label_transferName.text = transferModel.phone;
    }
    if (transferModel) {
        _button_sure.hidden = NO;
        _label_transferName.hidden = NO;
        _image_go.hidden = YES;
    }else{
        _button_sure.hidden = YES;
        _label_transferName.hidden = YES;
        _image_go.hidden = NO;
    }
}

// 点击转让
- (IBAction)pressSure:(id)sender {
    WEAKSELF;
    [SVProgressHUD showWithStatus:@"正在转让..."];
    [self.myNetWork net_transferMachineWithUserId:_transferModel.ID id:_myMachineModel.ID BlockRequest:^(NSString *infoStr, RequestState state) {
        if (state == net_succes) {
            if (weakSelf.block) {
                weakSelf.block(YES);
            }
            [SVProgressHUD showSuccessWithStatus:@"转让成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showSuccessWithStatus:infoStr];
        }
        [SVProgressHUD dismissWithDelay:1.0];
    }];
}

- (IBAction)pressTransfer:(id)sender {
    WEAKSELF;
    QFBMachineTransUsersController *vc = [[QFBMachineTransUsersController alloc] init];
    vc.block = ^(QFBUserModel *model) {
        weakSelf.transferModel = model;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end







