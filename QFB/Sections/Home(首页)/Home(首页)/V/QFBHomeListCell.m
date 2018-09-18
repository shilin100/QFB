//
//  QFBHomeListCell.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeListCell.h"
#import "QFBListButton.h"
#import "QFBBusinessInfoController.h"               // 商户信息
#import "QFBInvitingAnAllyController.h"             // 邀请盟友
#import "WantMachineViewController.h"               // 购买机器
#import "QFBActivateMachineController.h"            // 机器激活
#import "AccounMessageViewController.h"             // 实名认证
#import "FriendContactViewController.h"             // 合伙人通讯
#import "FriendUpgradeViewController.h"             // 合伙人升级


@interface QFBHomeListCell ()

@property (nonatomic, strong) NSMutableArray<QFBHomeListModel *> *modeArray;

@end


@implementation QFBHomeListCell

+ (instancetype)initWithTableView:(UITableView *)tableView model:(NSMutableArray<QFBHomeListModel *> *)listArray
{
    static NSString *cellID = @"QFBHomeListCell";
    QFBHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell loadListView:listArray];
    return cell;
}

- (void)loadListView:(NSMutableArray<QFBHomeListModel *> *)listArray
{
    if (_modeArray.count != listArray.count) {  // 创建button
        _modeArray = listArray;
        for (UIButton *btn in self.subviews) {
            [btn removeFromSuperview];
        }
        for (int i = 0; i < listArray.count; i++) {
            CGFloat w = 60;
            CGFloat h = w * 4 / 3;
            CGFloat jw = (ScreenWidth - 4 * 60) / 4;
            CGFloat x = jw / 2 + (jw + w) * (i % 4);
            CGFloat y = h * (i / 4);
            QFBListButton *button = [[QFBListButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(pressListBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    for (int i = 0; i < listArray.count; i++) {
        QFBListButton *button = [self viewWithTag:100 + i];
        [button sd_setImageWithURL:[NSURL URLWithString:listArray[i].url] forState:UIControlStateNormal];
        [button setTitle:listArray[i].value forState:UIControlStateNormal];
    }
}

- (void)pressListBtn:(UIButton *)btn
{
    DLog(@"click = %@",btn.titleLabel.text);
    NSInteger index = btn.tag - 100;
    switch (index) {
        case 0:         //  商户信息
        {
            QFBBusinessInfoController *vc = [[QFBBusinessInfoController alloc] init];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:         //  邀请合伙人
        {
            QFBInvitingAnAllyController *vc = [[QFBInvitingAnAllyController alloc] init];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:         //  我要机器
        {
            WantMachineViewController *vc = [[WantMachineViewController alloc] init];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:         //  机器激活
        {
            QFBActivateMachineController * vc = [[QFBActivateMachineController alloc] init];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:         //  实名认证
        {
            AccounMessageViewController * vc = [AccounMessageViewController new];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:         //  合伙人通讯
        {
            FriendContactViewController * vc = [FriendContactViewController new];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:         //  合伙人升级
        {
            FriendUpgradeViewController * vc = [FriendUpgradeViewController new];
            [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:         //  其它
        {
            if (!btn.titleLabel.text) {
                [SVProgressHUD showInfoWithStatus:@"更多功能敬请期待"];
                [SVProgressHUD dismissWithDelay:1.0];
            }else{
                
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
