//
//  QFBHomeInfoCell.m
//  QFB
//
//  Created by qqq on 2018/9/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeInfoCell.h"
#import "LMJScrollTextView2.h"

@interface QFBHomeInfoCell ()

@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (weak, nonatomic) IBOutlet LMJScrollTextView2 *scrollTextView;

@end

@implementation QFBHomeInfoCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(NSArray *)titleArray
{
    static NSString *cellID = @"QFBHomeInfoCell";
    QFBHomeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.scrollTextView.textFont = [UIFont systemFontOfSize:10];
        cell.scrollTextView.textAlignment = NSTextAlignmentLeft;
        cell.scrollTextView.textStayTime = 1.5;
    }
    [cell loadTitleData:titleArray];
    return cell;
}

- (void)loadTitleData:(NSArray *)titleArray
{
    if (titleArray.count > 0) {
        self.scrollTextView.textDataArr = titleArray;
        [self.scrollTextView startScrollBottomToTopWithNoSpace];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.view_back.layer.cornerRadius = 5;
    self.view_back.layer.masksToBounds = YES;
    self.view_back.layer.borderColor = [UIColor colorWithRed:102 / 255.0 green:171 / 255.0 blue:225 / 255.0 alpha:1].CGColor;
    self.view_back.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end
