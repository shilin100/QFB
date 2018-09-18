//
//  QFBAllianceTeamTableViewCell.m
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceTeamTableViewCell.h"

@interface QFBAllianceTeamTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *label_all;
@property (weak, nonatomic) IBOutlet UILabel *label_add;
@property (weak, nonatomic) IBOutlet UILabel *label_act;

@end

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

- (void)loadCellModel:(QFBAllianceModel *)model
{
    _label_all.text = [NSString stringWithFormat:@"%g",model.allTurnover];
    _label_add.text = [NSString stringWithFormat:@"%ld",model.addNumber];
    _label_act.text = [NSString stringWithFormat:@"%ld",model.activationNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
