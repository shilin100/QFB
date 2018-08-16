//
//  QFBAllianceTeamTableViewCell.m
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceTeamTableViewCell.h"

@implementation QFBAllianceTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(2, 5);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
