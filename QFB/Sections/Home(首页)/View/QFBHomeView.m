//
//  QFBHomeView.m
//  QFB
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeView.h"

@interface QFBHomeView ()

@property(nonatomic,strong)SDCycleScrollView * SDscrollView;
@property(nonatomic,strong)QFBHomeFunctionButtonView * functionButtonView;
@property(nonatomic,strong)UILabel * balance;
@property(nonatomic,strong)UILabel * incomeamount;
@property(nonatomic,strong)UILabel * ranking;
@property(nonatomic,strong)UILabel * activation;
@property(nonatomic,strong)UILabel * ally;

@end

@implementation QFBHomeView

-(instancetype)init{
    if (self = [super init]) {
        
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight* 1.7);
        });
        

        [self addSubview:scrollView];
        self.scrollview = scrollView;
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
        bgImgView.image = [UIImage imageNamed:@"Home头部"];
        [contentView addSubview:bgImgView];
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(contentView).with.offset(0);
            make.height.mas_equalTo(@185);
        }];
        
        UILabel * income = [UILabel new];
        income.text = @"我的收益";
        income.font = XFont(12);
        income.textColor = [UIColor whiteColor];
        //income.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:income];
        //self.totalEarningCount = totalEarningCount;
        
        [income mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView).with.offset(24);
            make.top.mas_equalTo(contentView).with.offset(33);
            make.height.mas_equalTo(@12);
        }];
        
        UILabel * incomeamount = [UILabel new];
        incomeamount.text = @"";
        incomeamount.font = XFont(30);
        incomeamount.textColor = [UIColor colorWithRed:253.001/255.0 green:227.248/255.0 blue:181.565/255.0 alpha:1];
        [contentView addSubview:incomeamount];
        self.incomeamount = incomeamount;
        
        [incomeamount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView).with.offset(24);
            make.top.mas_equalTo(contentView).with.offset(51);
            make.height.mas_equalTo(@24);
        }];
        //提现
        UIImageView * withdrawalImgView = [[UIImageView alloc]init];
        //bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        withdrawalImgView.image = [UIImage imageNamed:@"提现"];
        [contentView addSubview:withdrawalImgView];
        [withdrawalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentView).with.offset(-24);
            make.top.mas_equalTo(contentView).with.offset(33);
            make.width.mas_equalTo(@19);
            make.height.mas_equalTo(@42);
        }];
        
        UILabel * withdrawal = [UILabel new];
        withdrawal.text = @"提现";
        withdrawal.font = XFont(12);
        withdrawal.numberOfLines = 0;
        withdrawal.textColor = [UIColor blackColor];
        [contentView addSubview:withdrawal];
        //self.totalEarningCount = totalEarningCount;
        
        [withdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentView).with.offset(-28);
            make.top.mas_equalTo(contentView).with.offset(41);
            make.height.mas_equalTo(@30);
            make.width.mas_equalTo(@12);
        }];
        //余额
        UIImageView * balanceImgView = [[UIImageView alloc]init];
        //bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        balanceImgView.image = [UIImage imageNamed:@"我的余额"];
        [contentView addSubview:balanceImgView];
        [balanceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentView).with.offset(-45);
            make.top.mas_equalTo(contentView).with.offset(33);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@42);
        }];
        
        UILabel * mybalance = [UILabel new];
        mybalance.text = @"我的余额";
        mybalance.font = XFont(10);
        mybalance.textColor = [UIColor whiteColor];
        [contentView addSubview:mybalance];
        [mybalance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentView).with.offset(-97);
            make.top.mas_equalTo(contentView).with.offset(40);
        }];
        
        UILabel * balance = [UILabel new];
        balance.text = @"";
        balance.font = XFont(15);
        balance.textColor = [UIColor colorWithRed:253.001/255.0 green:227.001/255.0 blue:181.996/255.0 alpha:1];
        [contentView addSubview:balance];
        self.balance = balance;
        [balance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(mybalance).mas_offset(10);
            make.top.mas_equalTo(contentView).with.offset(56);
        }];
        
        
        //新增
        UIImageView * newImgView = [[UIImageView alloc]init];
        //bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        newImgView.image = [UIImage imageNamed:@"新增排行背景图"];
        [contentView addSubview:newImgView];
        [newImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView).with.offset(24);
            make.right.mas_equalTo(contentView).with.offset(-24);
            make.top.mas_equalTo(contentView).with.offset(81);
            make.height.mas_equalTo(@37);
        }];
        
        UILabel * newally = [UILabel new];
        newally.text = @"新增盟友";
        newally.font = XFont(12);
        newally.textColor = [UIColor blackColor];
        [contentView addSubview:newally];
        [newally mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView).with.offset(54);
            make.top.mas_equalTo(contentView).with.offset(85);
        }];
        
        UILabel * ally = [UILabel new];
        ally.text = @"";
        ally.font = XFont(15);
        ally.textColor = [UIColor colorWithRed:253.001/255.0 green:227.001/255.0 blue:181.996/255.0 alpha:1];
        [contentView addSubview:ally];
        self.ally = ally;
        [ally mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView).with.offset(64);
            make.top.mas_equalTo(contentView).with.offset(101);
        }];
        
        UILabel * myranking = [UILabel new];
        myranking.text = @"我的排行";
        myranking.font = XFont(12);
        myranking.textColor = [UIColor blackColor];
        [contentView addSubview:myranking];
        [myranking mas_makeConstraints:^(MASConstraintMaker *make) {    
            make.centerX.equalTo(contentView);
            make.top.mas_equalTo(contentView).with.offset(85);
        }];
       
        UILabel * ranking = [UILabel new];
        ranking.text = @"";
        ranking.font = XFont(15);
        ranking.textColor = [UIColor colorWithRed:253.001/255.0 green:227.001/255.0 blue:181.996/255.0 alpha:1];
        [contentView addSubview:ranking];
        self.ranking = ranking;
        [ranking mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.top.mas_equalTo(contentView).with.offset(101);
        }];
        
        UILabel * myactivation = [UILabel new];
        myactivation.text = @"激活用户";
        myactivation.font = XFont(12);
        myactivation.textColor = [UIColor blackColor];
        [contentView addSubview:myactivation];
        [myactivation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentView).with.offset(-54);
            make.top.mas_equalTo(contentView).with.offset(85);
        }];
        
        UILabel * activation = [UILabel new];
        activation.text = @"";
        activation.font = XFont(15);
        activation.textColor = [UIColor colorWithRed:253.001/255.0 green:227.001/255.0 blue:181.996/255.0 alpha:1];
        [contentView addSubview:activation];
        self.activation = activation;
        [activation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentView).with.offset(-67);
            make.top.mas_equalTo(contentView).with.offset(101);
        }];
        
        //轮播图
        UIView * shufflingView = [[UIView alloc] init];
        shufflingView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:shufflingView];
        [shufflingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentView).with.offset(24);
            make.right.mas_equalTo(contentView).with.offset(-24);
            make.top.mas_equalTo(contentView).with.offset(128);
            make.height.mas_equalTo(@134);
            //make.width.mas_equalTo(@329);
        }];
        
        //NSArray * homeImagesArray = [NSArray arrayWithObjects:@"http://fxapp.fengzhuan.org/fulianmeng/routing/1.png",@"http://fxapp.fengzhuan.org/fulianmeng/routing/2.png",@"http://fxapp.fengzhuan.org/fulianmeng/routing/3.png", nil];
        //加载滚动视图
        _SDscrollView = [[SDCycleScrollView alloc] init];
        _SDscrollView.backgroundColor = [UIColor whiteColor];
        _SDscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _SDscrollView.placeholderImage = [UIImage imageNamed:@"banner_placeholder_icon"];
        _SDscrollView.currentPageDotColor = [UIColor redColor];
        _SDscrollView.pageDotColor = [UIColor whiteColor];
        _SDscrollView.autoScrollTimeInterval = 3.;// 自动滚动时间间隔
        
        //_cycleScrollView = scrollView;
        [shufflingView addSubview:_SDscrollView];
        
        [_SDscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        flowLayout.minimumLineSpacing = 5.0;
        flowLayout.minimumInteritemSpacing = 5.0;
        //item大大小
        flowLayout.itemSize = CGSizeMake((ScreenWidth-40)/4, 100);
        
        //初始化
        QFBHomeFunctionButtonView * functionButtonView= [[QFBHomeFunctionButtonView  alloc]initWithFrame:CGRectMake(0, 0, 19, 19) collectionViewLayout:flowLayout];
        self.functionButtonView = functionButtonView;
        functionButtonView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:functionButtonView];
        
        [functionButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shufflingView.mas_bottom).offset(24);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(@220);
        }];
        
        UIView * information = [[UIView alloc] init];
        information.backgroundColor = [UIColor whiteColor];
        information.layer.masksToBounds = YES;
        information.layer.cornerRadius = 10.f;
        information.layer.borderWidth = 1.f;
        information.layer.borderColor = [UIColor colorWithRed:34/255.0 green:135/255.0 blue:224/255.0 alpha:1].CGColor;
        [contentView addSubview:information];
        [information mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(functionButtonView.mas_bottom).offset(0);
            make.left.mas_equalTo(24);
            make.right.mas_equalTo(-24);
            //make.bottom.equalTo(contentView.mas_bottom).offset(-49);
            make.height.mas_equalTo(@32);
        }];
        
        UILabel * informationLab = [UILabel new];
        informationLab.text = @"支付信息";
        informationLab.font = XFont(14);
        informationLab.textColor = [UIColor colorWithRed:34/255.0 green:135/255.0 blue:224/255.0 alpha:1];
        [information addSubview:informationLab];
        [informationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(information);
            make.left.mas_equalTo(18);
            //make.top.mas_equalTo(10);
        }];
        
        UIImageView * informationImgView = [[UIImageView alloc]init];
        informationImgView.image = [UIImage imageNamed:@"信息小喇叭"];
        [information addSubview:informationImgView];
        [informationImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(information);
            make.left.mas_equalTo(76);
        }];
        
        QFBHomeTableView * QHtableView = [[QFBHomeTableView alloc]initWithFrame:CGRectZero];
        //self.tableView = tableView;


        [contentView addSubview:QHtableView];

        [QHtableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(information.mas_bottom).offset(20);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(627);
        }];
    }
    return self;
}
- (void)MenuAndRooting:(NSArray*)rootingArray MenuArray:(NSArray*)MenuArray
{
    _rootingArray = rootingArray;
    NSMutableArray * arr = [NSMutableArray array];
    for (RootingModel * model in rootingArray) {
        [arr addObject:model.url];
    }
    _SDscrollView.imageURLStringsGroup = [NSArray arrayWithArray:arr];
    
    NSLog(@"%@",MenuArray);
    
    self.functionButtonView.dataArray = MenuArray;
    
    [self.functionButtonView reloadData];
}
-(void)getBalanceStr:(NSString *)BalanceStr
{
    
    NSString * string = [NSString stringWithFormat:@"%@元",BalanceStr];
    self.balance.text = string;
}
-(void)getEarningsStr:(NSString *)EarningsStr
{
    
    NSString * string = [NSString stringWithFormat:@"%@元",EarningsStr];
    self.incomeamount.text = string;
}
-(void)getAddFriendStr:(NSString *)AddFriendStr MyRankingStr:(NSString *)MyRankingStr AddUserStr:(NSString *)AddUserStr{
    self.ally.text = [NSString stringWithFormat:@"%@名",AddFriendStr];
    self.ranking.text = [NSString stringWithFormat:@"%@",MyRankingStr];
    self.activation.text = [NSString stringWithFormat:@"%@名",AddUserStr];
}
-(void)setQFBHomeFunctionButtonViewModel:(id)viewModel{
    self.functionButtonView.viewModel = viewModel;
}
@end
