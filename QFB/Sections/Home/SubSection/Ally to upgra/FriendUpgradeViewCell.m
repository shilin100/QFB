//
//  FriendUpgradeViewCell.m
//  ZFLM
//
//  Created by BoFeng on 2018/6/19.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import "FriendUpgradeViewCell.h"
#import "QFBHomeModel.h"

@interface FriendUpgradeViewCell ()
{
    
    __weak IBOutlet UILabel *_priceLabel;
    __weak IBOutlet UILabel *_contentLabel;
    __weak IBOutlet UIImageView *_imageView;
}
@end
@implementation FriendUpgradeViewCell
- (void)getDataWithModel:(FriendUpgrade *)model
{
    //[_imageView cacheImageDataWithImageUrl:model.reserveTwo placeholder:nil];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.reserveTwo] placeholderImage:[UIImage imageNamed:@""]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    _contentLabel.text = model.reserve;
    
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
