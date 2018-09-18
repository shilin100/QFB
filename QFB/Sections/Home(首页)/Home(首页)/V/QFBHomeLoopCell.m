//
//  QFBHomeLoopCell.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeLoopCell.h"
#import "SDCycleScrollView.h"

@interface QFBHomeLoopCell ()

@property (nonatomic, strong) SDCycleScrollView *SDscrollView;

@end

@implementation QFBHomeLoopCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(NSArray *)urlArray
{
    static NSString *cellID = @"QFBHomeLoopCell";
    QFBHomeLoopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadLoopView];
    }
    cell.SDscrollView.imageURLStringsGroup = urlArray;
    return cell;
}

- (void)loadLoopView
{
    _SDscrollView = [[SDCycleScrollView alloc] init];
    _SDscrollView.backgroundColor = [UIColor whiteColor];
    _SDscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    _SDscrollView.placeholderImage = [UIImage imageNamed:@"banner_placeholder_icon"];
    _SDscrollView.currentPageDotColor = [UIColor redColor];
    _SDscrollView.pageDotColor = [UIColor whiteColor];
    _SDscrollView.autoScrollTimeInterval = 3.;// 自动滚动时间间隔
    [self addSubview:_SDscrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _SDscrollView.frame = CGRectMake(15, 0, self.mj_w - 30, self.mj_h);
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
