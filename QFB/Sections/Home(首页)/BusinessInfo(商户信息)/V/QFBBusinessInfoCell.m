//
//  QFBBusinessInfoCell.m
//  QFB
//
//  Created by qqq on 2018/9/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBusinessInfoCell.h"

@interface QFBBusinessInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_number;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (nonatomic, weak) QFBBusinessInfoModel *infoMode;

@end

@implementation QFBBusinessInfoCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBBusinessInfoModel *)model
{
    static NSString *cellID = @"QFBBusinessInfoCell";
    QFBBusinessInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell loadBusinessInfoModel:model];
    return cell;
}

- (void)loadBusinessInfoModel:(QFBBusinessInfoModel *)model
{
    if (model.remarks) {
        _label_name.text = model.remarks;
    }else{
        _label_name.text = @"未实名";
    }
    _label_number.text = model.psamCode;
    _label_time.text = model.activeTime;
    _infoMode = model;
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
