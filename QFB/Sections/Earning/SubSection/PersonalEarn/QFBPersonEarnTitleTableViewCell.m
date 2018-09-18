//
//  QFBPersonEarnTitleTableViewCell.m
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBPersonEarnTitleTableViewCell.h"
#import "QFBPersonalEarnModel.h"

@implementation QFBPersonEarnTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithModel:(QFBPersonalEarnModel *)model
{
    if ([model.month integerValue] < 10) {
        _monthLabel.text = [NSString stringWithFormat:@"0%@月",model.month];
    } else {
        _monthLabel.text = [NSString stringWithFormat:@"%@月",model.month];
    }
    _priceLabel.text = [NSString stringWithFormat:@"%@",model.countprice];
}


@end
