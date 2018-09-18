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
@property(nonatomic,strong)UILabel *monthEarning;
@property(nonatomic,strong)QFBEarningTypeView * personalEarning;
@property(nonatomic,strong)QFBEarningTypeView * teamEarning;
@property(nonatomic,strong)QFBEarningTypeView * brandEarning;
@property(nonatomic,strong)UIView *contentHeaderView;
@property(nonatomic,strong)UIView *contentFootView;

@end

@implementation QFBEarningView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        QFBEarningTableView * tableView = [[QFBEarningTableView alloc] initWithFrame:frame];
        self.tableView = tableView;
        [self addSubview:tableView];

        UIView * contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        self.contentHeaderView = contentView;
        self.contentFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, 140)];
        tableView.tableFooterView = _contentFootView;
        tableView.tableHeaderView = contentView;

        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        bgImgView.contentMode = UIViewContentModeScaleToFill;
        bgImgView.image = [UIImage imageNamed:@"收益背景图"];
        [contentView addSubview:bgImgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight - 44, ScreenWidth, 44)];
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"盟友";
        [contentView addSubview:titleLabel];
        
        // 图标试图
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(self.mj_w / 2 - 80, SafeAreaTopHeight + 20, 160, 160) items:nil];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        [pieChart strokeChart];
        pieChart.hideValues = YES;
        pieChart.duration = 0.5;
        pieChart.shouldHighlightSectorOnTouch = NO;
        pieChart.innerCircleRadius = 110;
        [contentView addSubview:pieChart];
        self.pieChart = pieChart;
        
        UILabel * totalEarningCount = [[UILabel alloc] initWithFrame:CGRectMake(pieChart.mj_w / 2 - 70, pieChart.mj_h / 2 - 30, 140, 30)];
        totalEarningCount.text = @"¥0";
        totalEarningCount.font = XFont(27);
        totalEarningCount.textColor = [UIColor whiteColor];
        totalEarningCount.textAlignment = NSTextAlignmentCenter;
        [pieChart addSubview:totalEarningCount];
        self.totalEarningCount = totalEarningCount;
        
        UILabel * totalEarningSign = [[UILabel alloc] initWithFrame:CGRectMake(pieChart.mj_w / 2 - 70, pieChart.mj_h / 2 + 5, 140, 20)];
        totalEarningSign.text = @"累计收益(元)";
        totalEarningSign.font = XFont(15);
        totalEarningSign.textColor = [UIColor whiteColor];
        totalEarningSign.textAlignment = NSTextAlignmentCenter;
        [pieChart addSubview:totalEarningSign];
        
        _monthEarning = [[UILabel alloc] initWithFrame:CGRectMake(pieChart.mj_w / 2 - 70, CGRectGetMaxY(totalEarningSign.frame), 140, 15)];
        _monthEarning.text = @"当月交易0元";
        _monthEarning.font = XFont(12);
        _monthEarning.textColor = [UIColor whiteColor];
        _monthEarning.textAlignment = NSTextAlignmentCenter;
//        [pieChart addSubview:_monthEarning];

        CGFloat w = self.mj_w / 3;
        QFBEarningTypeView * personalEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xFDE3B6)];
        [personalEarning setTitle:@"个人收益" andPercent:@"50%"];
        [contentView addSubview:personalEarning];
        self.personalEarning = personalEarning;
        personalEarning.frame = CGRectMake(w / 2 - 40, CGRectGetMaxY(pieChart.frame) + 25, 80, 40);
        

        QFBEarningTypeView * teamEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0xF3C0FD)];
        [teamEarning setTitle:@"团队收益" andPercent:@"25%"];
        [contentView addSubview:teamEarning];
        self.teamEarning = teamEarning;
        teamEarning.frame = CGRectMake(1.5 * w - 40, CGRectGetMaxY(pieChart.frame) + 25, 80, 40);

        QFBEarningTypeView * brandEarning = [QFBEarningTypeView initWithColor:HEXCOLOR(0x7134FD)];
        [brandEarning setTitle:@"品牌收益" andPercent:@"25%"];
        [contentView addSubview:brandEarning];
        self.brandEarning = brandEarning;
        brandEarning.frame = CGRectMake(2.5 * w - 40, CGRectGetMaxY(pieChart.frame) + 25, 80, 40);
        
        QFBEarningLevelView * levelView = [QFBEarningLevelView initWithLevel:@"0"];
        [contentView addSubview:levelView];
        levelView.frame = CGRectMake(0, CGRectGetMaxY(brandEarning.frame) + 10, self.mj_w, 27);
        self.levelView = levelView;

        UILabel * beyondPartner = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w / 2 - 75, CGRectGetMaxY(levelView.frame) + 10, 150, 20)];
        beyondPartner.text = @"恭喜您已超越 15 个伙伴";
        beyondPartner.font = XFont(11);
        beyondPartner.textColor = [UIColor whiteColor];
        beyondPartner.textAlignment = NSTextAlignmentCenter;
        beyondPartner.backgroundColor = HEXCOLOR_ALPHA(0x010100, 0.24);
        beyondPartner.layer.cornerRadius = 10;
        beyondPartner.layer.masksToBounds = YES;
        [contentView addSubview:beyondPartner];
        self.beyondPartner = beyondPartner;

        // 头部试图frame
        contentView.frame = CGRectMake(0, 0, self.mj_w, CGRectGetMaxY(beyondPartner.frame) + 30);
        bgImgView.frame = CGRectMake(0, 0, self.mj_w, CGRectGetMaxY(beyondPartner.frame) + 10);

        UIImageView * upPathway = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.mj_w, 30)];
        upPathway.contentMode = UIViewContentModeScaleAspectFill;
        upPathway.image = [UIImage imageNamed:@"提升途径背景"];
        [_contentFootView addSubview:upPathway];


        UILabel * upPathWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.mj_w - 40, upPathway.mj_h)];
        upPathWayLabel.text = @"提升途径";
        upPathWayLabel.font = XFont(14);
        upPathWayLabel.textColor = [UIColor whiteColor];
        [upPathway addSubview:upPathWayLabel];


        UIButton * extendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentFootView addSubview:extendBtn];
        [extendBtn setImage:[UIImage imageNamed:@"扩展商户"] forState:UIControlStateNormal];
        self.extendBtn = extendBtn;
        [extendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upPathway.mas_bottom).offset(10);
            make.left.mas_equalTo(@45);
            make.size.mas_equalTo(CGSizeMake(76, 76));
        }];
        
        UIButton * inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentFootView addSubview:inviteBtn];
        [inviteBtn setImage:[UIImage imageNamed:@"邀请伙伴"] forState:UIControlStateNormal];
        self.inviteBtn = inviteBtn;
        [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upPathway.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(76, 76));
        }];

        
        UIButton * buyDeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentFootView addSubview:buyDeviceBtn];
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
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:personal color:HEXCOLOR(0xFDE3B6)],
                       [PNPieChartDataItem dataItemWithValue:team color:HEXCOLOR(0xF3C0FD)],
                       [PNPieChartDataItem dataItemWithValue:brand color:HEXCOLOR(0x7134FD)],
                       ];
    [self.pieChart updateChartData:items];
//    [self.pieChart recompute];
    [self.pieChart strokeChart];
    float totalSum = personal + team + brand;
    [_personalEarning setTitle:@"个人收益" andPercent:[NSString stringWithFormat:@"%%%.2f",personal/totalSum*100]];
    [_teamEarning setTitle:@"团队收益" andPercent:[NSString stringWithFormat:@"%%%.2f",team/totalSum*100]];
    [_brandEarning setTitle:@"品牌收益" andPercent:[NSString stringWithFormat:@"%%%.2f",brand/totalSum*100]];
}



-(void)setTableViewModel:(id)viewModel{
    self.tableView.viewModel = viewModel;
}

-(void)changeLevel:(NSString *)level{
    [self.levelView changeLevel:level];
}

@end





