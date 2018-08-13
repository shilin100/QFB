//
//  QFBEarningLevelView.m
//  QFB
//
//  Created by qqq on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningLevelView.h"
@interface QFBEarningLevelView ()
@property(nonatomic,strong)UILabel *leftLevel;
@property(nonatomic,strong)UILabel *rightLevel;

@end

@implementation QFBEarningLevelView

+(QFBEarningLevelView *)initWithLevel:(NSString*)level{
    QFBEarningLevelView * view = [QFBEarningLevelView new];
    
    UIView * whiteline = [UIView new];
    whiteline.backgroundColor = [UIColor whiteColor];
    [view addSubview:whiteline];
    [whiteline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@6);
        make.left.mas_equalTo(@19);
        make.right.mas_equalTo(@-19);
        make.centerY.equalTo(view);
    }];

    UIView * coverline = [UIView new];
    coverline.backgroundColor = HEXCOLOR(0xFDE3B6);
    [view addSubview:coverline];
    [coverline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@6);
        make.left.mas_equalTo(@19);
        make.width.mas_equalTo(@(kSCREEN_WIDTH/2 - 19));
        make.centerY.equalTo(view);
    }];
    
    UILabel * leftLevel = [UILabel new];
    leftLevel.text = [NSString stringWithFormat:@"V%@",level];
    leftLevel.font = XFont(14);
    leftLevel.textAlignment = NSTextAlignmentCenter;
    leftLevel.backgroundColor = HEXCOLOR(0xFDE3B6);
    leftLevel.layer.cornerRadius = 13;
    leftLevel.layer.masksToBounds = YES;
    leftLevel.layer.borderColor = HEXCOLOR(0xFDE3B6).CGColor;
    leftLevel.layer.borderWidth = 1;
    [view addSubview:leftLevel];
    view.leftLevel = leftLevel;
    
    [leftLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.width.mas_equalTo(@26);
        make.height.mas_equalTo(@26);
        make.left.mas_equalTo(@61);
    }];

    UILabel * rightLevel = [UILabel new];
    rightLevel.text = [NSString stringWithFormat:@"V%ld",level.integerValue+1];
    rightLevel.font = XFont(14);
    rightLevel.textColor = HEXCOLOR(0xDABB84);
    rightLevel.textAlignment = NSTextAlignmentCenter;
    rightLevel.backgroundColor = HEXCOLOR(0x02EBFC);
    rightLevel.layer.cornerRadius = 13;
    rightLevel.layer.masksToBounds = YES;
    rightLevel.layer.borderColor = HEXCOLOR(0xFDE3B6).CGColor;
    rightLevel.layer.borderWidth = 1;
    [view addSubview:rightLevel];
    view.rightLevel = rightLevel;

    [rightLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.width.mas_equalTo(@26);
        make.height.mas_equalTo(@26);
        make.right.mas_equalTo(@-61);
    }];

    
    
    return view;
}

-(void)changeLevel:(NSString*)level{
    self.leftLevel.text = [NSString stringWithFormat:@"V%@",level];
    self.rightLevel.text = [NSString stringWithFormat:@"V%ld",level.integerValue+1];
}


@end
