//
//  QFBEarningView.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningView.h"
#import "QFBEarningTableViewCell.h"


@interface QFBEarningView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * dataArray;

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
        
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
        [self addSubview:tableView];

        
    }
    return self;
}

#pragma mark  ==TableViewDelegate/DataSource

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

-(NSArray *)dataArray{
    if (!_dataArray) {
        
        _dataArray = @[@{@"title":@"个人收益",@"icon":@"个人",},
                       @{@"title":@"团队收益",@"icon":@"团队",},
                       @{@"title":@"品牌收益",@"icon":@"团队收益",}];
    }
    return _dataArray;
}


@end
