//
//  QFBActivateTableViewController.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBActivateTableViewController.h"
#import "QFBActivateCell.h"
#import "QFBActivateMachineView.h"
#import "QFBMachineTransferController.h"

@interface QFBActivateTableViewController ()<UITableViewDelegate, UITableViewDataSource, ActivateCellDelegate>

@property (nonatomic, strong) QFBNetWorkTool *network;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<QFBMachineModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<QFBMachineModel *> *searchArray;
@property (nonatomic, strong) UIView *popView;

@end

@implementation QFBActivateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.tableView.contentOffset.y < 0) {
        [self.tableView setContentOffset:CGPointZero];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.dataArray.count != self.searchArray.count) {
        self.searchArray = [NSMutableArray arrayWithArray:self.dataArray];
        [self.tableView reloadData];
    }
}

#pragma mark - 搜索pasam码
- (void)searchPasamString:(NSString *)pasamStr
{
    if ([pasamStr isEqualToString:@""]) {
        self.searchArray = [NSMutableArray arrayWithArray:self.dataArray];
        [self.tableView reloadData];
        return ;
    }
    [self.searchArray removeAllObjects];
    for (QFBMachineModel *model in self.dataArray) {
        if ([model.psamCode containsString:pasamStr]) {
            [self.searchArray addObject:model];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - 下拉刷新
- (void)loadRefresh
{
    WEAKSELF;
    // status 0:未激活    1:已激活   2:未达标
    [self.network net_getMachineActiveWithPsamCode:nil status:self.title blockRequest:^(NSMutableArray<QFBMachineModel *> *arr, RequestState state) {
        if (state == net_succes) {
            weakSelf.dataArray   = [NSMutableArray arrayWithArray:arr];
            weakSelf.searchArray = [NSMutableArray arrayWithArray:arr];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - ActivateCellDelegate
// 点击激活 转让 按钮
- (void)machineModel:(QFBMachineModel *)model type:(int)type
{
    WEAKSELF;
    if (type == 0) {            //  转让
        QFBMachineTransferController *vc = [[QFBMachineTransferController alloc] init];
        vc.myMachineModel = model;
        vc.block = ^(BOOL isSuccess) {  // 转让成功
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [[DCSpeedy dc_getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if (type == 1){       //  激活
        if (self.popView) {
            return ;
        }
        [SVProgressHUD showWithStatus:@"正在加载..."];
        [self.network net_activeMachineWithPsamId:model.ID blockRequest:^(QFBMachineActivateModel *machineModel, RequestState state) {
            [SVProgressHUD dismiss];
            if (state == net_succes) {
                [weakSelf createPopView:machineModel];
            }
        }];
        
    }
}

//  创建激活弹窗
- (void)createPopView:(QFBMachineActivateModel *)model
{
    UIView *cv = [DCSpeedy dc_getCurrentVC].view;
    QFBActivateMachineView *activateMachineView = [QFBActivateMachineView initWithFrame:CGRectMake(0, 0, 250, 420) model:model];
    self.popView = [[UIView alloc] initWithFrame:cv.bounds];
    self.popView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    activateMachineView.center = CGPointMake(self.popView.mj_w / 2, self.popView.mj_h / 2);
    [self.popView addSubview:activateMachineView];
    [cv addSubview:self.popView];
    WEAKSELF;
    activateMachineView.block = ^(int activateState) {  // 0：取消  1：成功    2：失败   3：验证码错误
        if (activateState == 1) {
            [weakSelf.popView removeFromSuperview];
            weakSelf.popView = nil;
            [weakSelf.tableView.mj_header beginRefreshing];
        }else if (activateState == 3){
            
        }else{
            [weakSelf.popView removeFromSuperview];
            weakSelf.popView = nil;
        }
    };
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFBActivateCell *cell = [QFBActivateCell initWithTableView:tableView model:self.searchArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - UI
- (void)createTableView
{
    self.network = [[QFBNetWorkTool alloc] init];
    CGFloat h = SafeAreaTopHeight + 55 + 44;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - h - (SafeAreaBottomHeight - 49)) style:UITableViewStylePlain];
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 适配 ios 11
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    [self createHeaderRefreshing];
}

- (void)createHeaderRefreshing
{
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadRefresh];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end







