//
//  TeamTradeTableViewCell.m
//  ZFLM
//
//  Created by BoFeng on 2018/5/22.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import "TeamTradeTableViewCell.h"
#import "QFBTeamEarnModel.h"
#import "QFBBrandEarnModel.h"

@interface TeamTradeTableViewCell ()
{
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_tradeMoneyLabel;
    __weak IBOutlet UILabel *_makeMoneyLabel;
    __weak IBOutlet UILabel *_connectLabel;
    __weak IBOutlet UIView *_lineView;
}
@end
@implementation TeamTradeTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEarnCellWithModel:(QFBTeamEarnModel*)model{
    if (IS_STR_EMPTY(model.reserve)) {
        _nameLabel.text = @"好友";
    } else {
        _nameLabel.text = model.reserve;
    }

    _tradeMoneyLabel.text = [NSString stringWithFormat:@"%@",model.transactionPrice];
    _makeMoneyLabel.text = [NSString stringWithFormat:@"%@",model.level];
    NSString *userId = [NSString stringWithFormat:@"%@",[kDefault objectForKey:USER_IDk]];
    NSString *parentId = [NSString stringWithFormat:@"%d",(int)model.psamId];
    
    if ([parentId isEqualToString:userId]) {
        _connectLabel.text = @"直接好友";
        _connectLabel.textColor = HEXCOLOR(0xFF943C);
    } else {
        _connectLabel.text = @"间接好友";
        _connectLabel.textColor = HEXCOLOR(0x3F84C5);
    }

}

-(void)setBrandCellWithModel:(QFBBrandEarnModel*)model{
    if (IS_STR_EMPTY(model.reserve)) {
        _nameLabel.text = @"好友";
    } else {
        _nameLabel.text = model.reserve;
    }
    NSString *userId = [NSString stringWithFormat:@"%@",[kDefault objectForKey:USER_IDk]];
    NSString *parentId = [NSString stringWithFormat:@"%@",model.psamId];
    if ([parentId isEqualToString:userId]) {
        _connectLabel.text = @"直接好友";
        _connectLabel.textColor = HEXCOLOR(0xFF943C);
    } else {
        _connectLabel.text = @"间接好友";
        _connectLabel.textColor = HEXCOLOR(0x3F84C5);
    }
    _tradeMoneyLabel.text = @"";
    _makeMoneyLabel.text = model.price;

}

@end
