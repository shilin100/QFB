//
//  QFBEarningTypeView.m
//  QFB
//
//  Created by qqq on 2018/8/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningTypeView.h"

@interface QFBEarningTypeView ()
@property(nonatomic,strong)UILabel *earningLabel;

@end

@implementation QFBEarningTypeView
+(QFBEarningTypeView *)initWithColor:(UIColor*)color{
    QFBEarningTypeView * view = [QFBEarningTypeView new];

    UIView * circle = [UIView new];
    circle.backgroundColor = color;
    [view addSubview:circle];
    circle.layer.cornerRadius = 6;
    circle.layer.masksToBounds = YES;
    
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.centerY.equalTo(view);
        make.left.mas_equalTo(@0);
    }];
    
    UILabel * earningLabel = [UILabel new];
    earningLabel.text = @"个人收益\n50%";
    earningLabel.font = XFont(12);
    earningLabel.textColor = HEXCOLOR(0x40424C);
    earningLabel.numberOfLines = 2;
//    earningLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:earningLabel];
    view.earningLabel = earningLabel;
    
    [earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(@0);
        make.left.equalTo(circle.mas_right).offset(9);
    }];
    
    
    return view;
}

-(void)setTitle:(NSString*)title andPercent:(NSString*)percent{
    NSString * totalStr = [NSString stringWithFormat:@"%@\n%@",title,percent];

    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSRange rang = [totalStr rangeOfString:percent];

    [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:XFont(15),NSFontAttributeName, nil] range:rang];
    self.earningLabel.attributedText = attributeString;
    
}


@end
