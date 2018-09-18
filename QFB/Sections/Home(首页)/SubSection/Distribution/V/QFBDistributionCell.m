//
//  QFBDistributionCell.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionCell.h"

@interface QFBDistributionCell()

@property (weak, nonatomic) IBOutlet UILabel *label_left;
@property (weak, nonatomic) IBOutlet UILabel *label_right;

@end

@implementation QFBDistributionCell

+ (instancetype)initWithTableView:(UITableView *)tv model:(QFBDistributionCellModel *)model
{
    static NSString *cellStr = @"QFBDistributionCell";
    QFBDistributionCell *cell = [tv dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellStr owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.label_left.text = model.left;
    cell.label_right.text = model.right;
    return cell;
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
