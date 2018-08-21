//
//  QFBEarningView.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningView.h"
#import "QFBEarningTableView.h"
#import "QFBEarningLevelView.h"

@interface QFBEarningView ()

@property(nonatomic,strong)UILabel *beyondPartner;
@property(nonatomic,strong)UILabel *totalEarningCount;
@property(nonatomic,strong)QFBEarningTypeView * personalEarning;
@property(nonatomic,strong)QFBEarningTypeView * teamEarning;
@property(nonatomic,strong)QFBEarningTypeView * brandEarning;
@property(nonatomic,strong)UIView *contentView;


@end

@implementation QFBEarningView

-(instancetype)init{
    if (self = [super init]) {
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            scrollView.contentSize = CGSizeMake(ScreenWidth, 750);
        });
        
        [self addSubview:scrollView];
        self.scrollview = scrollView;
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));;
        }];

        
        UIView * contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:contentView];
        self.contentView = contentView;

        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(scrollView);
            make.width.mas_equalTo(scrollView);
            make.height.mas_equalTo(scrollView);//此处保证容器View高度的动态变化 大于等于0.f的高度
        }];

        
        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.image = [UIImage imageNamed:@"收益背景图"];
        [contentView addSubview:bgImgView];
        
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(@0);
            make.height.mas_equalTo(375);
        }];
        
        
        UILabel * totalEarningCount = [UILabel new];
        totalEarningCount.text = @"¥0.00";
        totalEarningCount.font = XFont(27);
        totalEarningCount.textColor = [UIColor whiteColor];
        totalEarningCount.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:totalEarningCount];
        self.totalEarningCount = totalEarningCount;
        
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
        [contentView addSubview:totalEarningSign];
        
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
        [contentView addSubview:monthEarning];
        
        [monthEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(@140);
            make.height.mas_equalTo(@20);
            make.top.equalTo(totalEarningSign.mas_bottom).offset(0);
        }];

        
        QFBEarningTypeView * personalEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xFDE3B6)];
        [personalEarning setTitle:@"个人收益" andPercent:@"%50"];
        [contentView addSubview:personalEarning];
        self.personalEarning = personalEarning;
        
        [personalEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@40);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@260);
        }];
        
        QFBEarningTypeView * teamEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xF3C0FD)];
        [teamEarning setTitle:@"团队收益" andPercent:@"%25"];
        [contentView addSubview:teamEarning];
        self.teamEarning = teamEarning;
        
        [teamEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@260);
        }];

        QFBEarningTypeView * brandEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0x7134FD)];
        [brandEarning setTitle:@"品牌收益" andPercent:@"%25"];
        [contentView addSubview:brandEarning];
        self.brandEarning = brandEarning;
        
        [brandEarning mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(@-40);
            make.width.mas_equalTo(@80);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(@260);
        }];
        
        QFBEarningLevelView * levelView = [QFBEarningLevelView initWithLevel:@"0"];
        [contentView addSubview:levelView];
        self.levelView = levelView;
        
        [levelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(@0);
            make.height.mas_equalTo(@27);
            make.top.equalTo(brandEarning.mas_bottom).offset(10);
        }];

        UILabel * beyondPartner = [UILabel new];
        beyondPartner.text = @"恭喜您已超越 15 个伙伴";
        beyondPartner.font = XFont(11);
        beyondPartner.textColor = [UIColor whiteColor];
        beyondPartner.textAlignment = NSTextAlignmentCenter;
        beyondPartner.backgroundColor = HEXCOLOR_ALPHA(0x010100, 0.24);
        beyondPartner.layer.cornerRadius = 10;
        beyondPartner.layer.masksToBounds = YES;

        [contentView addSubview:beyondPartner];
        self.beyondPartner = beyondPartner;
        
        [beyondPartner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@150);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(@20);
            make.top.equalTo(levelView.mas_bottom).offset(5);
        }];

        
        QFBEarningTableView * tableView = [[QFBEarningTableView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
        self.tableView = tableView;
        [contentView addSubview:tableView];

        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgImgView.mas_bottom).offset(30);
            make.left.mas_equalTo(@24);
            make.right.mas_equalTo(@-24);
            make.height.mas_equalTo(@140);
        }];
        
        UIImageView * upPathway = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        upPathway.contentMode = UIViewContentModeScaleAspectFill;
        upPathway.image = [UIImage imageNamed:@"提升途径背景"];
        [contentView addSubview:upPathway];
        
        [upPathway mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tableView.mas_bottom).offset(10);
            make.height.mas_equalTo(18);
            make.left.right.mas_equalTo(0);
        }];

        UILabel * upPathWayLabel = [UILabel new];
        upPathWayLabel.text = @"提升途径";
        upPathWayLabel.font = XFont(14);
        upPathWayLabel.textColor = [UIColor whiteColor];
        [contentView addSubview:upPathWayLabel];
        
        [upPathWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(tableView.mas_bottom).offset(10);
            make.height.mas_equalTo(18);
            make.left.right.mas_equalTo(28);
        }];

        UIButton * extendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:extendBtn];
        [extendBtn setImage:[UIImage imageNamed:@"扩展商户"] forState:UIControlStateNormal];
        self.extendBtn = extendBtn;
        
        [extendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upPathway.mas_bottom).offset(10);
            make.left.mas_equalTo(@45);
            make.size.mas_equalTo(CGSizeMake(76, 76));
        }];
        
        UIButton * inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:inviteBtn];
        [inviteBtn setImage:[UIImage imageNamed:@"邀请伙伴"] forState:UIControlStateNormal];
        self.inviteBtn = inviteBtn;
        
        [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upPathway.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(76, 76));
        }];

        
        UIButton * buyDeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:buyDeviceBtn];
        [buyDeviceBtn setImage:[UIImage imageNamed:@"购买机器"] forState:UIControlStateNormal];
        self.buyDeviceBtn = buyDeviceBtn;
        
        [buyDeviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upPathway.mas_bottom).offset(10);
            make.right.mas_equalTo(@-45);
            make.size.mas_equalTo(CGSizeMake(76, 76));
        }];


        
    }
    return self;
}


-(void)setBeyondPartnerStr:(NSString *)beyondPartnerStr{
    _beyondPartnerStr = beyondPartnerStr;
    
    NSString * totalStr = [NSString stringWithFormat:@"恭喜您已超越 %@ 个伙伴",beyondPartnerStr];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:totalStr];
    NSRange rang = [totalStr rangeOfString:beyondPartnerStr];
    
    [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:XFont(12),NSFontAttributeName,HEXCOLOR(0xFBC25D),NSForegroundColorAttributeName, nil] range:rang];
    self.beyondPartner.attributedText = attributeString;

}

-(void)setTotalEarningCountStr:(NSString *)totalEarningCountStr{
    _totalEarningCountStr = totalEarningCountStr;
    self.totalEarningCount.text = [NSString stringWithFormat:@"¥%@",totalEarningCountStr];
}

-(void)creatChartWith:(float)personal :(float)team :(float)brand{
    if (!self.pieChart) {
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:personal color:HEXCOLOR(0xFDE3B6)],
                           [PNPieChartDataItem dataItemWithValue:team color:HEXCOLOR(0xF3C0FD)],
                           [PNPieChartDataItem dataItemWithValue:brand color:HEXCOLOR(0x7134FD)],
                           ];
        
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        [pieChart strokeChart];
        self.pieChart = pieChart;
        [self.contentView addSubview:pieChart];
        
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
        
        float totalSum = personal + team + brand;
        
        
        [_personalEarning setTitle:@"个人收益" andPercent:[NSString stringWithFormat:@"%%%.2f",personal/totalSum*100]];
        [_teamEarning setTitle:@"团队收益" andPercent:[NSString stringWithFormat:@"%%%.2f",team/totalSum*100]];
        [_brandEarning setTitle:@"品牌收益" andPercent:[NSString stringWithFormat:@"%%%.2f",brand/totalSum*100]];

        
    }
    
}

-(void)setTableViewModel:(id)viewModel{
    self.tableView.viewModel = viewModel;
}

-(void)changeLevel:(NSString *)level{
    [self.levelView changeLevel:level];
}

@end
