//
//  QFBTeamEarnViewController.m
//  QFB
//
//  Created by qqq on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBTeamEarnViewController.h"
#import "TeamTradeTableViewCell.h"
#import "QFBTeamEarnModel.h"

@interface QFBTeamEarnViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *earnLabel;

@end

@implementation QFBTeamEarnViewController
static NSString * TeamTradeTableViewCellIdentifier = @"TeamTradeTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队收益";
    self.dataArray = [NSMutableArray array];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TeamTradeTableViewCell" bundle:nil] forCellReuseIdentifier:TeamTradeTableViewCellIdentifier];
    self.headView.frame = CGRectMake(0, 0, ScreenWidth, 160 + (SafeAreaTopHeight - 64));
    [self.view addSubview:self.headView];
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.headView.frame) - (SafeAreaBottomHeight - 49));

    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    [self.tableview.mj_header beginRefreshing];
}


-(void)requestData{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/transaction/selectTeamReturns.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[QFBTeamEarnModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"transactions"]]];
            [self.tableview reloadData];
            self.earnLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"allPrice"]];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamTradeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TeamTradeTableViewCellIdentifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    QFBTeamEarnModel * model = self.dataArray[indexPath.row];
    [cell setEarnCellWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}


@end






