//
//  QFBBusinessDetailsCell.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBusinessDetailsCell.h"

@interface QFBBusinessDetailsCell()

@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_money;

@end

@implementation QFBBusinessDetailsCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBBusinessDetailsModel *)model
{
    static NSString *cellID = @"QFBBusinessDetailsCell";
    QFBBusinessDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.label_time.text = model.transactionTime;
    cell.label_money.text = model.transactionPrice;
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
