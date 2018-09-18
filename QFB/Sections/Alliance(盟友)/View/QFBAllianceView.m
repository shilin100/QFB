//
//  QFBAllianceView.m
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceView.h"
#import "ZZCircleProgress.h"


@interface QFBAllianceView ()

@property(nonatomic,strong)ZZCircleProgress * progress;

@property(nonatomic,strong)UILabel * cumulativenum;     // 累计盟友数
@property(nonatomic,strong)UILabel * partnernum;        // 今日新增盟友

@property(nonatomic,strong)UILabel * directlynew;       // 直接盟友-今日新增
@property(nonatomic,strong)UILabel * directlytotal;     // 直接盟友-累计共计

@property(nonatomic,strong)UILabel * indirectnew;       // 间接盟友-今日新增
@property(nonatomic,strong)UILabel * indirecttotal;     // 间接盟友-累计共计

@property (nonatomic, strong) NSMutableArray<QFBAllianceModel *> *dataArray;

@end


@implementation QFBAllianceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h / 2)];
        bgImgView.image = [UIImage imageNamed:@"联盟上半部背景"];
        [self addSubview:bgImgView];
        
        UIImageView * bgBImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mj_h / 2, self.mj_w, self.mj_h / 2)];
        bgBImgView.image = [UIImage imageNamed:@"联盟下半部背景"];
        [self addSubview:bgBImgView];
        
        QFBAllianceTableView * QHtableView = [[QFBAllianceTableView alloc] initWithFrame:frame];
        QHtableView.mj_h = screen_height - SafeAreaBottomHeight;
        [self addSubview:QHtableView];
        self.tableView = QHtableView;
        
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, 100)];
        self.tableView.tableHeaderView = contentView;

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight - 44, ScreenWidth, 44)];
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"盟友";
        [contentView addSubview:titleLabel];
        
        ZZCircleProgress * progress = [[ZZCircleProgress alloc] initWithFrame:CGRectMake((self.mj_w - 176) / 2, 10 + SafeAreaTopHeight, 176, 176)];
        self.progress = progress;
        progress.backgroundColor = [UIColor clearColor];
        progress.pathBackColor = [UIColor whiteColor];
        progress.startAngle = 270.;
        progress.reduceAngle = 0.;
        progress.strokeWidth = 6.00;
        progress.duration = 0.5;
        progress.showPoint = YES;
        progress.showProgressText  = NO;
        progress.increaseFromLast = NO;
        progress.pathFillColor = [UIColor colorWithRed:255/255.0 green:197.997/255.0 blue:97.002/255.0 alpha:1];
        [contentView addSubview:progress];
        
        UILabel * cumulativenum = [[UILabel alloc] initWithFrame:CGRectMake(0, progress.mj_h / 2 - 42, progress.mj_w, 42)];
        cumulativenum.text = @"0";
        cumulativenum.font = XBFont(40);
        cumulativenum.textAlignment = 1;
        cumulativenum.textColor = [UIColor colorWithRed:255/255.0 green:197.997/255.0 blue:97.002/255.0 alpha:1];
        self.cumulativenum = cumulativenum;
        [progress addSubview:cumulativenum];
        
        UILabel * cumulativen = [[UILabel alloc] initWithFrame:CGRectMake(0, progress.mj_h / 2 + 20, progress.mj_w, 25)];
        cumulativen.text = @"累计盟友数";
        cumulativen.textAlignment = 1;
        cumulativen.font = XFont(21);
        cumulativen.textColor = [UIColor whiteColor];
        [progress addSubview:cumulativen];
        
        UILabel * partnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.mj_w / 2 - 65, CGRectGetMaxY(progress.frame) + 20, 130, 30)];
        self.partnernum = partnerLabel;
        partnerLabel.text = @"今日新增盟友 0";
        partnerLabel.font = XFont(12);
        partnerLabel.backgroundColor = [UIColor whiteColor];
        partnerLabel.textAlignment = 1;
        partnerLabel.layer.cornerRadius = 5;
        partnerLabel.layer.masksToBounds = YES;
        partnerLabel.textColor = [UIColor blackColor];
        [contentView addSubview:partnerLabel];

        //
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(partnerLabel.frame) + 20, self.mj_w, 80)];
        bottomView.backgroundColor = [UIColor lightGrayColor];
        [contentView addSubview:bottomView];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(bottomView.mj_w / 2 - 0.5, 15, 1, bottomView.mj_h - 30)];
        line.backgroundColor = [UIColor colorWithRed:135.998/255.0 green:135.998/255.0 blue:135.998/255.0 alpha:1];
        [bottomView addSubview:line];
        
        UILabel * directly = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bottomView.mj_w / 2, 40)];
        directly.text = @"直接盟友数(人)";
        directly.textAlignment = 1;
        directly.font = XFont(15);
        directly.textColor = [UIColor colorWithRed:255/255.0 green:197.997/255.0 blue:97.002/255.0 alpha:1];
        [bottomView addSubview:directly];
        
        UILabel * directlynew = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, bottomView.mj_w / 2, 20)];
        directlynew.text = @"今日新增  0";
        directlynew.textAlignment = 1;
        directlynew.font = XFont(11);
        directlynew.textColor = [UIColor blackColor];
        self.directlynew = directlynew;
        [bottomView addSubview:directlynew];

        UILabel * directlytotal = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, bottomView.mj_w / 2, 20)];
        directlytotal.text = @"累计共计  0";
        directlytotal.textAlignment = 1;
        directlytotal.font = XFont(11);
        directlytotal.textColor = [UIColor blackColor];
        [bottomView addSubview:directlytotal];
        self.directlytotal = directlytotal;
        
        UILabel * indirect = [[UILabel alloc] initWithFrame:CGRectMake(bottomView.mj_w / 2, 0, bottomView.mj_w / 2, 40)];
        indirect.text = @"间接盟友数(人)";
        indirect.textAlignment = 1;
        indirect.font = XFont(15);
        indirect.textColor = [UIColor colorWithRed:255/255.0 green:197.997/255.0 blue:97.002/255.0 alpha:1];
        [bottomView addSubview:indirect];
        
        UILabel * indirectnew = [[UILabel alloc] initWithFrame:CGRectMake(bottomView.mj_w / 2, 40, bottomView.mj_w / 2, 20)];
        indirectnew.text = @"今日新增  0";
        indirectnew.textAlignment = 1;
        indirectnew.font = XFont(11);
        indirectnew.textColor = [UIColor blackColor];
        [bottomView addSubview:indirectnew];
        self.indirectnew = indirectnew;
    
        UILabel * indirecttotal = [[UILabel alloc] initWithFrame:CGRectMake(bottomView.mj_w / 2, 60, bottomView.mj_w / 2, 20)];
        indirecttotal.text = @"累计共计  0";
        indirecttotal.textAlignment = 1;
        indirecttotal.font = XFont(11);
        indirecttotal.textColor = [UIColor blackColor];
        [bottomView addSubview:indirecttotal];
        self.indirecttotal = indirecttotal;
        
        contentView.mj_h = CGRectGetMaxY(bottomView.frame);
    }
    return self;
}

//  获取累计盟友数、直接盟友、间接盟友
-(void)getTransactionDict:(NSDictionary*)dict
{
    NSInteger result3 = [dict[@"result3"] integerValue];    //  间接盟友数
    NSInteger result4 = [dict[@"result4"] integerValue];    //  直接盟友数
    self.cumulativenum.text = [NSString stringWithFormat:@"%ld",result3 + result4]; // 累计盟友数
    self.progress.progress = (result3 + result4) / 1000.0;
    self.indirecttotal.text = [NSString stringWithFormat:@"累计共计 %ld",(long)result3];    // 间接盟友-累计共计
    self.directlytotal.text = [NSString stringWithFormat:@"累计共计 %ld",(long)result4];    // 直接盟友-累计共计
}

// 今日新增盟友数、今日新增直接盟友、今日新增间接盟友、团队激活商户数、今日新增盟友、累计激活商户
-(void)getTodayAddFriendsDict:(NSDictionary*)dict
{
    NSInteger result3 = [dict[@"result3"] integerValue];    // 今日新增-间接盟友
    NSInteger result4 = [dict[@"result4"] integerValue];    // 今日新增-直接盟友
    NSString *str = [NSString stringWithFormat:@"%ld",result3 + result4];
    self.partnernum.text = [NSString stringWithFormat:@"今日新增盟友 %@ 人", str];
    [DCSpeedy dc_messageAction:self.partnernum changeString:str andAllColor:[UIColor blackColor] andMarkColor:[UIColor orangeColor] andMarkFondSize:12];
    self.indirectnew.text = [NSString stringWithFormat:@"今日新增 %ld",result3];    // 今日新增-间接盟友
    self.directlynew.text = [NSString stringWithFormat:@"今日新增 %ld",result4];    // 今日新增-直接盟友
    
    NSInteger count1  = [dict[@"count1"] integerValue];     // 本月团队 今日新增
    NSInteger counts  = [dict[@"counts"] integerValue];     // 本月直营 今日新增
    self.dataArray.firstObject.addNumber = count1;
    self.dataArray.lastObject.addNumber = counts;
    [self refreshTableView:0];
}


// 本月直营商户交易额,直营累计激活商户,团队累计激活商户
- (void)getThisMonthMakeMoneyDict:(NSDictionary*)dict
{
    NSInteger counts = [dict[@"counts"] integerValue];      //  本月直营-累计激活商户
    NSInteger count1 = [dict[@"count1"] integerValue];      //  本月团队-累计激活商户
    double result1 = 0;                                     //  本月直营-商户交易额
    if (!LMJIsEmpty(dict[@"result1"])) {
        result1 = [dict[@"result1"] doubleValue];
    }
    self.dataArray.firstObject.activationNumber = count1;
    self.dataArray.lastObject.allTurnover = result1;
    self.dataArray.lastObject.activationNumber = counts;
    [self refreshTableView:0];
}


//  获取本月团队商户交易额
- (void)getTheTeamMonthBusinessPriceDict:(NSString *)price
{
    double p = 0;                                           //  本月团队-商户交易
    if (!LMJIsEmpty(price)) {
        p = [price doubleValue];
    }
    self.dataArray.firstObject.allTurnover = p;
    [self refreshTableView:0];
}

- (void)refreshTableView:(NSInteger *)count
{
    self.loadCount++;
    if (self.loadCount == 3) {
        self.loadCount = 0;
        [self.tableView loadCellModelArray:self.dataArray];
    }
}


-(void)setQFBAllianceTableViewModel:(id)viewModel
{
    self.tableView.viewModel = viewModel;
}

- (NSMutableArray<QFBAllianceModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        QFBAllianceModel *m0 = [[QFBAllianceModel alloc] init];
        QFBAllianceModel *m1 = [[QFBAllianceModel alloc] init];
        [_dataArray addObject:m0];
        [_dataArray addObject:m1];
    }
    return _dataArray;
}

@end











