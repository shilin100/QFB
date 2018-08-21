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
    
    __weak IBOutlet UIView *_lineView;
    __weak IBOutlet UILabel *_tradeLabel;
    __weak IBOutlet UILabel *_salesPriceLabel;
    __weak IBOutlet UILabel *_tradePriceLabel;
    __weak IBOutlet UILabel *_returnMoneyLabel;
    __weak IBOutlet UILabel *_nameLabel;
    NSInteger _count;
    BuyMachine *_buyMachine;
}
@end
@implementation BuyMachineTableViewCell
- (void)getDataWithModel:(BuyMachine *)model index:(NSInteger)index count:(NSInteger)count
{
    _buyMachine = model;
    if (index == count - 1) {
        _lineView.alpha = 0;
    } else {
        _lineView.alpha = 1;
    }
    _tradePriceLabel.hidden = YES;
    _tradeLabel.hidden = YES;
    _threeLabel.hidden = YES;
    _fourLabel.hidden = YES;
    //[_imageView cacheImageDataWithImageUrl:model.remarksTwo placeholder:nil];
     [_imageView sd_setImageWithURL:[NSURL URLWithString:model.remarksTwo] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = model.remarks;
    _returnMoneyLabel.text = [NSString stringWithFormat:@"返现 %@ 元",model.remarksThree];
    _salesPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - method

- (IBAction)addButtonClicked:(id)sender
{
    _count = [_countLabel.text integerValue];
    
    _count = _count + [_buyMachine.count integerValue];
    _countLabel.text = [NSString stringWithFormat:@"%ld",_count];
    if (_addButtonClick) {
        _addButtonClick(_countLabel.text,_buyMachine);
    }
}
- (IBAction)decreaseButtonClicked:(id)sender
{
    _count = [_countLabel.text integerValue];
    if (_count == 0) {
        return;
    }
    _count = _count - [_buyMachine.count integerValue];
    _countLabel.text = [NSString stringWithFormat:@"%ld",_count];
    if (_decreaseButtonClick) {
        _decreaseButtonClick(_countLabel.text,_buyMachine);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
