//
//  QFBEarningTableViewCell.m
//  QFB
//
//  Created by qqq on 2018/8/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningTableViewCell.h"

@implementation QFBEarningTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTitleAndIcon:(NSDictionary*)dic{
    self.titleIcon.image = [UIImage imageNamed:dic[@"icon"]];
    self.titleLabel.text = dic[@"title"];
    
    
}

@end
