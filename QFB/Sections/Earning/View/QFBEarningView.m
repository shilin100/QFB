//
//  QFBEarningView.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningView.h"

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
        totalEarningCount.textColor = [UIColor whiteColor];
        totalEarningCount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:totalEarningCount];
        
        [totalEarningCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.left.mas_equalTo(@50);
            make.height.mas_equalTo(@15);

        }];

        
        
    }
    return self;
}


@end
