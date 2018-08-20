//
//  QFBOrderTableViewCell.m
//  QFB
//
//  Created by qqq on 2018/8/17.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBOrderTableViewCell.h"

@implementation QFBOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithModel:(OrderModel*)model{
    
    [_leftImg sd_setImageWithURL:[NSURL URLWithString:model.remarksTwo]];
    NSString *status = [NSString stringWithFormat:@"%ld",(long)model.status];
    if ([status isEqualToString:@"0"]) {
        _flowState.text = @"待发货";
        _flowCompany.text = @"暂无信息";
        _flowNum.text = @"暂无信息";
    } else if ([status isEqualToString:@"1"]) {
        _flowState.text = @"已发货";
        if (IS_STR_EMPTY(model.remarks)) {
            _flowCompany.text = @"暂无信息";
        } else {
            _flowCompany.text = [NSString stringWithFormat:@"%@",model.remarks];
        }
        if (IS_STR_EMPTY(model.sendNum)) {
            _flowNum.text = @"暂无信息";
        } else {
            
            _flowNum.text = [NSString stringWithFormat:@"%@",model.sendNum];
        }
    }  else if ([status isEqualToString:@"2"]) {
        _flowState.text = @"待付款";
        _flowCompany.text = @"暂无信息";
        _flowNum.text = @"暂无信息";
    }

    
}

@end
