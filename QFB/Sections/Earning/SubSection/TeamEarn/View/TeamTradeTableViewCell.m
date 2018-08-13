//
//  TeamTradeTableViewCell.m
//  ZFLM
//
//  Created by BoFeng on 2018/5/22.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import "TeamTradeTableViewCell.h"

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

@end
