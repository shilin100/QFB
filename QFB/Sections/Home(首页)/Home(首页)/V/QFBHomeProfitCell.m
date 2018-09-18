//
//  QFBHomeProfitCell.m
//  QFB
//
//  Created by qqq on 2018/9/8.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeProfitCell.h"
#import "QFBDrawMoneyController.h"

@interface QFBHomeProfitCell()

@property (weak, nonatomic) IBOutlet UILabel *label_myProfit;   // 我的收益
@property (weak, nonatomic) IBOutlet UILabel *label_myBalance;  // 我的余额
@property (weak, nonatomic) IBOutlet UILabel *label_newFriends; // 新增盟友
@property (weak, nonatomic) IBOutlet UILabel *label_ranking;    // 我的排名
@property (weak, nonatomic) IBOutlet UILabel *label_activationUser; // 激活用户
@property (nonatomic, strong) QFBHomeUserModel* userModel;

@end

@implementation QFBHomeProfitCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBHomeUserModel *)model
{
    static NSString *cellID = @"QFBHomeProfitCell";
    QFBHomeProfitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell loadHomeUserModel:model];
    return cell;
}

- (void)loadHomeUserModel:(QFBHomeUserModel *)model
{
    _userModel = model;
    _label_myProfit.text = model.myProfit;
    _label_myBalance.text = model.myBalance;
    _label_newFriends.text = model.myAddFriend;
    _label_ranking.text = model.myNumber;
    _label_activationUser.text = model.myActiviNumber;
}

// 我要提现
- (IBAction)pressGetMoney:(id)sender {
    QFBDrawMoneyController *vc = [[QFBDrawMoneyController alloc] init];
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
