//
//  QFBActivateCell.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBActivateCell.h"

@interface QFBActivateCell()

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_code;
@property (weak, nonatomic) IBOutlet UIButton *button_activate;     //  已激活
@property (weak, nonatomic) IBOutlet UIButton *button_operation;    //  操作
@property (weak, nonatomic) IBOutlet UIButton *button_resubmit;     //  重新提交
@property (nonatomic, weak) QFBMachineModel *machineModel;

@end

@implementation QFBActivateCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBMachineModel *)model
{
    static NSString *cellID = @"QFBActivateCell";
    QFBActivateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.button_operation.layer.cornerRadius = 5;
        cell.button_resubmit.layer.cornerRadius = 5;
    }
    [cell loadMachineModel:model];
    return cell;
}

- (void)loadMachineModel:(QFBMachineModel *)model
{
    self.machineModel = model;
    self.label_name.text = model.reserve;
    self.label_code.text = model.psamCode;
    if ([model.activeStatus isEqualToString:@"2"]) {        // 重新提交
        self.button_activate.hidden  = YES;
        self.button_resubmit.hidden  = NO;
        self.button_operation.hidden = YES;
    }else if ([model.activeStatus isEqualToString:@"1"]){   //  已激活
        self.button_activate.hidden  = NO;
        self.button_resubmit.hidden  = YES;
        self.button_operation.hidden = YES;
    }else{                                                  // 未激活 操作
        self.button_activate.hidden  = YES;
        self.button_resubmit.hidden  = YES;
        self.button_operation.hidden = NO;
    }
}

// 1:转让+激活 2:转让 3:激活
- (void)showSelectAlertSheetWithChange:(int)isChange
{
    WEAKSELF;
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"操作" message:@"请选择您的操作?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    if (isChange == 2 || isChange == 1) {
        UIAlertAction* changeAction = [UIAlertAction actionWithTitle:@"转让" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(machineModel:type:)]) {
                [weakSelf.delegate machineModel:weakSelf.machineModel type:0];
            }
        }];
        [alert addAction:changeAction];
    }
    if (isChange == 3 || isChange == 1) {
        UIAlertAction* activateAction = [UIAlertAction actionWithTitle:@"激活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(machineModel:type:)]) {
                [weakSelf.delegate machineModel:weakSelf.machineModel type:1];
            }
        }];
        [alert addAction:activateAction];
    }
    [alert addAction:cancelAction];
    [[DCSpeedy dc_getCurrentVC] presentViewController:alert animated:YES completion:nil];
}


//  重新提交
- (IBAction)pressResubmit:(id)sender {
    [self showSelectAlertSheetWithChange:3];
}

//  操作
- (IBAction)pressOperation:(id)sender {
    [self showSelectAlertSheetWithChange:1];
}

//  已激活
- (IBAction)pressActivate:(id)sender {
    [self showSelectAlertSheetWithChange:2];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
