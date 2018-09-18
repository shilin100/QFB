//
//  QFBDistributionHeaderView.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionHeaderView.h"
#import "QFBAddressViewController.h"

@interface QFBDistributionHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
@property (weak, nonatomic) IBOutlet UILabel *label_phone;
@property (weak, nonatomic) IBOutlet UILabel *label_prompt;
@property (nonatomic, strong) QFBAddressModel *addModel;

@end

@implementation QFBDistributionHeaderView

+ (instancetype)initWithFrame:(CGRect)frame model:(QFBAddressModel *)addressModel
{
    QFBDistributionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"QFBDistributionHeaderView" owner:nil options:nil] objectAtIndex:0];
    view.frame = frame;
    [view loadAddressModel:addressModel];
    return view;
}

- (void)loadAddressModel:(QFBAddressModel *)model
{
    if (model) {
        _label_prompt.hidden = YES;
        _label_name.hidden = NO;
        _label_phone.hidden = NO;
        _label_address.hidden = NO;
    }else{
        _label_prompt.hidden = NO;
        _label_name.hidden = YES;
        _label_phone.hidden = YES;
        _label_address.hidden = YES;
    }
    _label_name.text = model.name;
    _label_phone.text = model.phone;
    _label_address.text = model.address;
    _addModel = model;
}

- (QFBAddressModel *)getSelelctorAddress
{
    return _addModel;
}

/**
 修改地址
 */
- (IBAction)pressClick:(id)sender {
    WEAKSELF;
    QFBAddressViewController *VC = [[QFBAddressViewController alloc] init];
    VC.addressID = self.addModel.ID;
    VC.blockAddress = ^(QFBAddressModel *model) {
        [weakSelf loadAddressModel:model];
    };
    [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:VC animated:YES];
}

@end



