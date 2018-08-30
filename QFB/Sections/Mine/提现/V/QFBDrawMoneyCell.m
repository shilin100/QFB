//
//  QFBDrawMoneyCell.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDrawMoneyCell.h"

@interface QFBDrawMoneyCell ()
@property (weak, nonatomic) IBOutlet UILabel *label_top;        //  返现方式
@property (weak, nonatomic) IBOutlet UILabel *label_Frozen;     //  冻结资金
@property (weak, nonatomic) IBOutlet UILabel *label_money;      //  可提现金
@property (weak, nonatomic) IBOutlet UILabel *label_method;     //  结算方式
@property (weak, nonatomic) IBOutlet UILabel *label_all;        //  所有资金

@end

@implementation QFBDrawMoneyCell

+ (instancetype) initWithCollectionView:(UICollectionView *)cv indexPath:(NSIndexPath *)path model:(QFBDrawMoneyCellModel *)model
{
    QFBDrawMoneyCell *cell = [cv dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:path];
    [cell loadDrawMoneyCellModel:model];
    return cell;
}

- (void)loadDrawMoneyCellModel:(QFBDrawMoneyCellModel *)model
{
    _label_top.text     = model.returnMode;
    _label_method.text  = [NSString stringWithFormat:@"结算方式：%@",model.setMode ? @"月结" : @"妙结"];
    _label_all.text     = [NSString stringWithFormat:@"%g",model.allMoney];
    _label_Frozen.text  = [NSString stringWithFormat:@"冻结资金(元) %g",model.frozenMoney];
    _label_money.text   = [NSString stringWithFormat:@"%g",model.useMoney];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end




