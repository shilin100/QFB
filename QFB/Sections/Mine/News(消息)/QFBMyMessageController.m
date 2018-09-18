//
//  QFBMyMessageController.m
//  QFB
//
//  Created by qqq on 2018/9/18.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMyMessageController.h"
#import "QFBMyMessageCell.h"

@interface QFBMyMessageController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray<QFBMessageModel *> *dataArray;

@end

@implementation QFBMyMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"消息";
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self createHeaderRefreshing];
}

- (void)loadRefresh
{
    WEAKSELF;
    [self.netWorkTool net_getNewsBlockRequest:^(NSMutableArray<QFBMessageModel *> *messageArray, RequestState state) {
        [weakSelf.myTableView.mj_header endRefreshing];
        weakSelf.dataArray = messageArray;
        [weakSelf.myTableView reloadData];
    }];
}

- (void)createHeaderRefreshing
{
    WEAKSELF;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadRefresh];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

#pragma mark - UITableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QFBMyMessageCell initWithTableView:tableView model:self.dataArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


@end












