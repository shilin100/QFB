//
//  QFBMyMessageCell.m
//  QFB
//
//  Created by qqq on 2018/9/18.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMyMessageCell.h"

@interface QFBMyMessageCell()

@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_news;

@end

@implementation QFBMyMessageCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBMessageModel *)model
{
    static NSString *cellID = @"QFBMyMessageCell";
    QFBMyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.label_time.text = model.createTime;
    cell.label_title.text = model.content;
    cell.label_news.text = model.remarks;
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
