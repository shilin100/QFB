//
//  QFBHomeActivityCell.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeActivityCell.h"
#import "QFBHomeActivityController.h"

@interface QFBHomeActivityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV_image;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_title2;
@property (weak, nonatomic) IBOutlet UILabel *label_time;

@property (nonatomic, strong) QFBHomeActivityModel *activityModel;

@end

@implementation QFBHomeActivityCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBHomeActivityModel *)model
{
    static NSString *cellID = @"QFBHomeActivityCell";
    QFBHomeActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell loadHomeActivityModel:model];
    return cell;
}

- (void)loadHomeActivityModel:(QFBHomeActivityModel *)model
{
    _activityModel = model;
    [_imageV_image sd_setImageWithURL:[NSURL URLWithString:model.merchantImg]];
    _label_title.text = model.title;
    _label_title2.text = @"";
    _label_time.text = [NSString stringWithFormat:@"%@-%@",model.startTime,model.endTime];
}

// 查看详情
- (IBAction)pressDetails:(id)sender {
    QFBHomeActivityController *vc = [[QFBHomeActivityController alloc] init];
    vc.recentId = _activityModel.ID;
    [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];   
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
