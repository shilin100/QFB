//
//  QFBAddressTableViewCell.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAddressTableViewCell.h"

@implementation QFBAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)defaultAddressBtnAction:(id)sender {
    if (self.setDefultBlock) {
        self.setDefultBlock(self.model);
    }

}
- (IBAction)editBtnAction:(id)sender {
    if (self.editBlock) {
        self.editBlock(self.model);
    }

}
- (IBAction)deleteBtnAction:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock(self.model);
    }

}


-(void)setCellWithModel:(QFBAddressModel*)model{
    _name.text = model.name;
    _address.text = model.address;
    _tel.text = model.phone;
    _defaultBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_defaultBtn setImage:[UIImage imageNamed:model.defaultAddress == 0 ? @"pay_point_icon" : @"unpay_point_icon"] forState:UIControlStateNormal];
    self.model = model;
}
@end





