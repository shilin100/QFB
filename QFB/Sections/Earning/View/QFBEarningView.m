//
//  QFBEarningView.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningView.h"
#import "QFBEarningTableViewCell.h"
#import "QFBEarningTableView.h"


@interface QFBEarningView ()


@end

@implementation QFBEarningView

-(instancetype)init{
    if (self = [super init]) {
        
        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.image = [UIImage imageNamed:@"收益背景图"];
        [self addSubview:bgImgView];
        
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(@0);
            make.height.mas_equalTo(375);
        }];
        
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                           [PNPieChartDataItem dataItemWithValue:20 color:PNBlue],
                           [PNPieChartDataItem dataItemWithValue:40 color:PNGreen],
                           ];

        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        [pieChart strokeChart];
        self.pieChart = pieChart;
        [self addSubview:pieChart];
        
        pieChart.hideValues = YES;
        pieChart.duration = 0.5;
        pieChart.shouldHighlightSectorOnTouch = NO;
        pieChart.innerCircleRadius = 120;
        [pieChart strokeChart];

        [pieChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(@75);
            make.size.mas_equalTo(CGSizeMake(166, 166));
        }];
        
        UILabel * totalEarningCount = [UILabel new];
        totalEarningCount.text = @"12345676";
        totalEarningCount.font = XFont(27);
        totalEarningCount.textColor = [UIColor whiteColor];
        totalEarningCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:totalEarningCount];
        
        [totalEarningCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(@140);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@120);
        }];
        
        
        UILabel * totalEarningSign = [UILabel new];
        totalEarningSign.text = @"累计收益(元)";
        totalEarningSign.font = XFont(15);
        totalEarningSign.textColor = [UIColor whiteColor];
        totalEarningSign.textAlignment = NSTextAlignmentCenter;
        [self addSubview:totalEarningSign];
        
        [totalEarningSign mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(@140);
            make.height.mas_equalTo(@20);
            make.top.equalTo(totalEarningCount.mas_bottom);
        }];

        
        UILabel * monthEarning = [UILabel new];
        monthEarning.text = @"当月交易75.33元";
        monthEarning.font = XFont(12);
        monthEarning.textColor = [UIColor whiteColor];
        monthEarning.textAlignment = NSTextAlignmentCenter;
        [self addSubview:monthEarning];
        
        [monthEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(@140);
            make.height.mas_equalTo(@20);
            make.top.equalTo(totalEarningSign.mas_bottom).offset(0);
        }];

        
        QFBEarningTypeView * personalEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xFDE3B6)];
        [personalEarning setTitle:@"个人收益" andPercent:@"%50"];
        [self addSubview:personalEarning];
        
        [personalEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@40);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@260);
        }];

        
        QFBEarningTypeView * teamEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xFDE3B6)];
        [teamEarning setTitle:@"团队收益" andPercent:@"%25"];
        [self addSubview:teamEarning];
        
        [teamEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@260);
        }];

        QFBEarningTypeView * brandEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xFDE3B6)];
        [brandEarning setTitle:@"品牌收益" andPercent:@"%25"];
        [self addSubview:brandEarning];
        
        [brandEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(@-40);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@260);
        }];
        
        
        QFBEarningTableView * tableView = [[QFBEarningTableView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
        self.tableView = tableView;
        [self addSubview:tableView];

        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgImgView.mas_bottom).offset(30);
            make.left.mas_equalTo(@24);
            make.right.mas_equalTo(@-24);
            make.height.mas_equalTo(@140);
        }];
        
        UIImageView * upPathway = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        upPathway.contentMode = UIViewContentModeScaleAspectFill;
        upPathway.image = [UIImage imageNamed:@"提升途径背景"];
        [self addSubview:upPathway];
        
        [upPathway mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tableView.mas_bottom).offset(10);
            make.height.mas_equalTo(18);
            make.left.right.mas_equalTo(0);
        }];

        UILabel * upPathWayLabel = [UILabel new];
        upPathWayLabel.text = @"提升途径";
        upPathWayLabel.font = XFont(14);
        upPathWayLabel.textColor = [UIColor whiteColor];
        [self addSubview:upPathWayLabel];
        
        [upPathWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(tableView.mas_bottom).offset(10);
            make.height.mas_equalTo(18);
            make.left.right.mas_equalTo(28);
        }];

    }
    return self;
}



@end
