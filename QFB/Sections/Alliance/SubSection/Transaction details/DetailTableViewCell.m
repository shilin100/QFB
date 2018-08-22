//
//  DetailTableViewCell.m
//  ZFLM
//
//  Created by BoFeng on 2018/7/4.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "AllianceModel.h"
@interface DetailTableViewCell ()
{
    __weak IBOutlet UILabel *_serviceNameLabel;
    __weak IBOutlet UILabel *_brandNameLabel;
    
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    __weak IBOutlet UILabel *_accountLabel;
    __weak IBOutlet UILabel *_phoneLabel;
    __weak IBOutlet UILabel *_psamNuLabel;
    __weak IBOutlet UILabel *_nameLabel;
}
@end
@implementation DetailTableViewCell
- (void)getTranscationDetailDataWithModel:(TransactionDetail *)model
{
    _brandNameLabel.text = model.transactionResult;
    _phoneLabel.text = model.phone;
    if (model.realName.length == 0) {
        _nameLabel.text = @"未实名";
    } else {
        _nameLabel.text = model.realName;
    }
    _serviceNameLabel.text = model.serviceName;
    _accountLabel.text = model.account;
    _moneyLabel.text = model.transactionPrice;
    _timeLabel.text = model.transactionTime;
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
