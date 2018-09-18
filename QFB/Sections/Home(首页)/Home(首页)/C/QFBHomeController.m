//
//  QFBHomeController.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeController.h"
#import "QFBHomeHeaderView.h"
#import "QFBHomeLoopCell.h"         // 轮播图
#import "QFBHomeActivityCell.h"     // 活动
#import "QFBHomeListCell.h"         // 8个按钮
#import "QFBHomeInfoCell.h"
#import "QFBHomeProfitCell.h"       // 热门


@interface QFBHomeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<QFBHomeSectionModel *> *dataArray;
@property (nonatomic, assign) NSInteger loadIndex;
@property (nonatomic, strong) QFBHomeUserModel *userModel;

@end

@implementation QFBHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHomeTableView]; // UI
    [self loadBlock];           // block
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

// 下拉刷新
- (void)loadMore:(BOOL)isMore
{
    // 判断登录是否异常
    [PublicData judgeUserByOnline:^(BOOL isOnLine, BOOL isSucceed) {
        if (!isSucceed) {
            [self endHeaderFooterRefreshing];
            [SVProgressHUD showInfoWithStatus:@"网络异常！"];
            [SVProgressHUD dismissWithDelay:1.5];
            return ;
        }
        if (isOnLine) { // 重新登录
            [self endHeaderFooterRefreshing];
            [PublicData logInAgain];
            return ;
        }
        [self loadData];
    }];
}

- (void)loadBlock
{
    
}

#pragma mark - network
- (void)loadData
{
    QFBHomeCellModel *cellLoop;
    QFBHomeCellModel *cellList;
    for (QFBHomeCellModel *model in self.dataArray.firstObject.cellArray) {
        if (model.type == Cell_Loop) {
            cellLoop = model;
        }else if (model.type == Cell_List){
            cellList = model;
        }
    }
    self.loadIndex = 0;
    WEAKSELF;
    //  轮播图片 和 8个按钮图标
    [self.network net_getHomeSevenIconblock:^(NSMutableArray<QFBHomeListModel *> *listArray, NSMutableArray *imageUrlArray, RequestState state) {
        if (state == net_succes) {
            cellLoop.cellModel = imageUrlArray;
            cellList.cellModel = listArray;
        }
        [weakSelf reloadTableView];
    }];
    
    // 获取总收益 profit：总收益   rankIng：排名
    [self.network net_getHomeTradeWithUserId:^(NSString *profit, NSString *rankIng, RequestState state) {
        if (state == net_succes) {
            weakSelf.userModel.myProfit = [NSString stringWithFormat:@"%@元",profit];
            if (rankIng) {
                weakSelf.userModel.myNumber = rankIng;
            }else{
                weakSelf.userModel.myNumber = @"暂无";
            }
        }
        [weakSelf reloadTableView];
    }];
    
    // 获取我info  model.remarks  余额
    [self.network net_getUserInfoWithUserID:[kDefault objectForKey:USER_IDk] blockRequest:^(QFBUserModel *model, RequestState state) {
        if (state == net_succes) {
            weakSelf.userModel.myBalance = [NSString stringWithFormat:@"%g元",model.remarks];
        }
        [weakSelf reloadTableView];
    }];
    
    // 获取首页联盟消息 friendNum新增盟友   activeNum激活用户
    [self.network net_getHomeCardMsgAndLMMessageWithId:^(QFBHomeCardModel *model, RequestState state) {
        if (state == net_succes) {
            weakSelf.userModel.myAddFriend = [NSString stringWithFormat:@"%@名",model.friendNum];
            weakSelf.userModel.myActiviNumber = [NSString stringWithFormat:@"%@名",model.activeNum];
            for (QFBHomeCellModel *cm in weakSelf.dataArray.firstObject.cellArray) {
                if (cm.type == Cell_Info) {
                    cm.cellModel = model.newsList;
                }
            }
        }
        [weakSelf reloadTableView];
    }];
    
    //  获取近期活动
    [self.network net_getRecentActWithOBrandId:^(NSMutableArray<QFBHomeActivityModel *> *modelArray, RequestState state) {
        if (state == net_succes) {
            BOOL isHav = NO;
            for (QFBHomeSectionModel *sm in self.dataArray) {
                if ([@"热门推选" isEqualToString:sm.sectionTitle]) {
                    sm.cellArray = modelArray;
                    isHav = YES;
                }
            }
            if (!isHav) {
                QFBHomeSectionModel *model1 = [[QFBHomeSectionModel alloc] init];
                model1.sectionTitle = @"热门推选";
                model1.cellArray = modelArray;
                [weakSelf.dataArray addObject:model1];
            }
        }
        [weakSelf reloadTableView];
    }];
}

- (void)reloadTableView
{
    self.loadIndex++;
    if (self.loadIndex == 5) {
        [self endHeaderFooterRefreshing];
        [self.tableView reloadData];
        if (self.dataArray.firstObject.cellArray.count > 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QFBHomeSectionModel *model = self.dataArray[section];
    return model.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFBHomeSectionModel *model = self.dataArray[indexPath.section];
    if (indexPath.section == 0) {
        QFBHomeCellModel *cell = model.cellArray[indexPath.row];
        if (cell.type == Cell_List){
            return [QFBHomeListCell initWithTableView:tableView model:cell.cellModel];
        }else if (cell.type == Cell_Loop){
            return [QFBHomeLoopCell initWithTableView:tableView model:cell.cellModel];
        }else if (cell.type == Cell_profit){
            return [QFBHomeProfitCell initWithTableView:tableView model:cell.cellModel];
        }else if (cell.type == Cell_Info){
            return [QFBHomeInfoCell initWithTableView:tableView model:cell.cellModel];
        }
    }else{
        NSMutableArray *array = model.cellArray;
        id object = array[indexPath.row];
        if ([object isKindOfClass:[QFBHomeActivityModel class]]) {
            return [QFBHomeActivityCell initWithTableView:tableView model:object];
        }else{
            return nil;
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerStr = @"HomeViewHeaderFooterView";
    QFBHomeSectionModel *model = self.dataArray[section];
    QFBHomeHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerStr];
    if (!view) {
        view = [[QFBHomeHeaderView alloc] initWithReuseIdentifier:headerStr];
    }
    [view setTitleText: model.sectionTitle];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFBHomeSectionModel *model = self.dataArray[indexPath.section];
    id object = model.cellArray[indexPath.row];
    if ([object isKindOfClass:[QFBHomeCellModel class]]) {
        QFBHomeCellModel *cellmodel = model.cellArray[indexPath.row];
        return cellmodel.cellHeight;
    }else{
        if ([object isKindOfClass:[QFBHomeActivityModel class]]) {
            return 80;
        }
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    QFBHomeSectionModel *model = self.dataArray[section];
    if (model.sectionTitle) {
        return 44;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - UI
- (void)createHomeTableView
{
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeaderRefreshing];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        self.userModel = [[QFBHomeUserModel alloc] init];
        QFBHomeSectionModel *model0 = [[QFBHomeSectionModel alloc] init];
        [_dataArray addObject:model0];
        
        QFBHomeCellModel *cellProfitr = [[QFBHomeCellModel alloc] init]; // 用户信息
        cellProfitr.type = Cell_profit;
        cellProfitr.cellHeight = 140;
        cellProfitr.cellModel = self.userModel;
        
        QFBHomeCellModel *cellLoop = [[QFBHomeCellModel alloc] init];    // 轮播图
        cellLoop.type = Cell_Loop;
        cellLoop.cellHeight = (ScreenWidth - 30) * 320 / 750;
        
        QFBHomeCellModel *cellList = [[QFBHomeCellModel alloc] init];    // 8个按钮
        cellList.type = Cell_List;
        cellList.cellHeight = 160;
        
        QFBHomeCellModel *cellInfo = [[QFBHomeCellModel alloc] init];    // 滚动的info
        cellInfo.type = Cell_Info;
        cellInfo.cellHeight = 60;
        
        NSMutableArray *cellArray = _dataArray.firstObject.cellArray;
        [cellArray removeAllObjects];
        [cellArray addObject:cellProfitr];
        [cellArray addObject:cellLoop];
        [cellArray addObject:cellList];
        [cellArray addObject:cellInfo];
    }
    return _dataArray;
}


- (void)dealloc
{
    logDealloc;
}

@end



