//
//  QFBAllianceView.m
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceView.h"
#import "ZZCircleProgress.h"
#import "QFBAllianceTableView.h"

@implementation QFBAllianceView

-(instancetype)init{
    if (self = [super init]) {
        
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight+49);
        });
        
        
        [self addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));;
        }];
        
        
        UIView * contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [scrollView addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(scrollView);
            make.width.mas_equalTo(scrollView);
            make.height.mas_equalTo(scrollView);//此处保证容器View高度的动态变化 大于等于0.f的高度
        }];
        
        
        UIImageView * bgImgView = [[UIImageView alloc]init];
        //bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.image = [UIImage imageNamed:@"联盟上半部背景"];
        [contentView addSubview:bgImgView];
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(contentView).with.offset(0);
            make.height.mas_equalTo(@327);
        }];
        
        ZZCircleProgress * progress = [[ZZCircleProgress alloc] init];
        //progress.backgroundColor = [UIColor redColor];
        
        [contentView addSubview:progress];
        progress.startAngle = 270.;
        progress.reduceAngle = 0.;
        progress.strokeWidth = 6.00;
        progress.duration = .5;
        progress.showPoint = YES;
        progress.showProgressText  = NO;
        progress.increaseFromLast = NO;
        progress.pathFillColor = [UIColor whiteColor];
        progress.progress =0.00;
        [progress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.top.mas_equalTo(73);
            make.width.mas_equalTo(@176);
            make.height.mas_equalTo(@176);
        }];
        
        
        
        UIView * partner = [[UIView alloc] init];
        partner.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:partner];
        [partner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.top.mas_equalTo(269);
            make.width.mas_equalTo(@134);
            make.height.mas_equalTo(@29);
        }];
        
        UILabel * partnerLabel = [UILabel new];
        partnerLabel.text = @"今日新增伙伴";
        partnerLabel.font = XFont(12);
        partnerLabel.textColor = [UIColor blackColor];
        [partner addSubview:partnerLabel];
        
        [partnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(partner);
            make.left.mas_equalTo(4);
        }];
        
        UILabel * partnernum = [UILabel new];
        partnernum.text = @"253人";
        partnernum.font = XFont(15);
        partnernum.textColor = [UIColor colorWithRed:253.001/255.0 green:227.001/255.0 blue:181.996/255.0 alpha:1];
        [partner addSubview:partnernum];
        
        [partnernum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(partner);
            make.left.mas_equalTo(87);
        }];
        
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:135.998/255.0 green:135.998/255.0 blue:135.998/255.0 alpha:1];
        [contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.top.mas_equalTo(339);
            make.width.mas_equalTo(@1);
            make.height.mas_equalTo(@50);
        }];
        
        UILabel * directly = [UILabel new];
        directly.text = @"直接盟友数(人)";
        directly.font = XFont(15);
        directly.textColor = [UIColor colorWithRed:255/255.0 green:197.997/255.0 blue:97.002/255.0 alpha:1];
        [contentView addSubview:directly];
        
        [directly mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(340);
            make.left.mas_equalTo(41);
        }];
        
        UILabel * directlynew = [UILabel new];
        directlynew.text = @"今日新增  10";
        directlynew.font = XFont(10);
        directlynew.textColor = [UIColor blackColor];
        [contentView addSubview:directlynew];
        
        [directlynew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(directly.mas_bottom).offset(11);
            make.centerX.mas_equalTo(directly);
        }];

        UILabel * directlytotal = [UILabel new];
        directlytotal.text = @"累计共计  105";
        directlytotal.font = XFont(10);
        directlytotal.textColor = [UIColor blackColor];
        [contentView addSubview:directlytotal];
        
        [directlytotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(directlynew.mas_bottom).offset(5);
            make.centerX.mas_equalTo(directly);
        }];
        
        UILabel * indirect = [UILabel new];
        indirect.text = @"间接盟友数(人)";
        indirect.font = XFont(15);
        indirect.textColor = [UIColor colorWithRed:255/255.0 green:197.997/255.0 blue:97.002/255.0 alpha:1];
        [contentView addSubview:indirect];
        
        [indirect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(340);
            make.right.mas_equalTo(-35);
        }];
        
        UILabel * indirectnew = [UILabel new];
        indirectnew.text = @"今日新增  10";
        indirectnew.font = XFont(10);
        indirectnew.textColor = [UIColor blackColor];
        [contentView addSubview:indirectnew];
        
        [indirectnew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(indirect.mas_bottom).offset(11);
            make.centerX.mas_equalTo(indirect);
        }];
        
        UILabel * indirecttotal = [UILabel new];
        indirecttotal.text = @"累计共计  105";
        indirecttotal.font = XFont(10);
        indirecttotal.textColor = [UIColor blackColor];
        [contentView addSubview:indirecttotal];
        
        [indirecttotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(indirectnew.mas_bottom).offset(5);
            make.centerX.mas_equalTo(indirect);
        }];
        
        UIImageView * bgBImgView = [[UIImageView alloc]init];
        //bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgBImgView.image = [UIImage imageNamed:@"联盟下半部背景"];
        [contentView addSubview:bgBImgView];
        [bgBImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bgImgView.mas_bottom).offset(74);
            make.left.right.mas_equalTo(contentView).with.offset(0);
            make.height.mas_equalTo(@297);
        }];
        
        QFBAllianceTableView * QHtableView = [[QFBAllianceTableView alloc]initWithFrame:CGRectZero];
        //self.tableView = tableView;
        QHtableView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:QHtableView];
        
        [QHtableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgImgView.mas_bottom).offset(86);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            //make.top.equalTo(contentView.mas_bottom).offset(0);
            make.height.mas_equalTo(287);
        }];
        
        
    }
    return self;
}

@end