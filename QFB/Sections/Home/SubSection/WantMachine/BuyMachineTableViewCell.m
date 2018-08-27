//
//  BuyMachineTableViewCell.m
//  ZFLM
//
//  Created by BoFeng on 2018/5/25.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import "BuyMachineTableViewCell.h"
#import "QFBHomeModel.h"

@interface BuyMachineTableViewCell ()
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_fourLabel;
    __weak IBOutlet UILabel *_threeLabel;
    __weak IBOutlet UILabel *_countLabel;
    __weak IBOutlet UILabel *_tradeLabel;
    __weak IBOutlet UILabel *_salesPriceLabel;
    __weak IBOutlet UILabel *_tradePriceLabel;
    __weak IBOutlet UILabel *_returnMoneyLabel;
    __weak IBOutlet UILabel *_nameLabel;
}

@property (nonatomic, weak) BuyMachine *buyMachine;

@end


@implementation BuyMachineTableViewCell
- (void)getDataWithModel:(BuyMachine *)model
{
    _buyMachine = model;
    _tradePriceLabel.hidden = YES;
    _tradeLabel.hidden = YES;
    _threeLabel.hidden = YES;
    _fourLabel.hidden = YES;
     [_imageView sd_setImageWithURL:[NSURL URLWithString:model.remarksTwo] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = model.remarks;
    _returnMoneyLabel.text = [NSString stringWithFormat:@"返现 %g 元",model.remarksThree];
    _salesPriceLabel.text = [NSString stringWithFormat:@"￥%g",model.price];
    _countLabel.text = [NSString stringWithFormat:@"%d",model.selectorCount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _countLabel.layer.borderColor = [UIColor orangeColor].CGColor;
}

#pragma mark - method

- (IBAction)addButtonClicked:(id)sender
{
    _buyMachine.selectorCount ++;
    _countLabel.text = [NSString stringWithFormat:@"%d",_buyMachine.selectorCount];
    if (self.buttonClick) {
        self.buttonClick(YES);
    }
}

- (IBAction)decreaseButtonClicked:(id)sender
{
    if (_buyMachine.selectorCount == 0) {
        return ;
    }
    _buyMachine.selectorCount --;
    _countLabel.text = [NSString stringWithFormat:@"%d",_buyMachine.selectorCount];
    if (self.buttonClick) {
        self.buttonClick(YES);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
