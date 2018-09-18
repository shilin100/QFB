//
//  QFBBaseViewController.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseViewController.h"
#import <MJRefresh.h>

@interface QFBBaseViewController ()

@end

@implementation QFBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    AdjustsScrollViewInsetNever(self, self.tableView);
    self.network = [[QFBNetWorkTool alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[QFBResourcesTool tool_getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView setContentOffset:CGPointZero];
    }
}

#pragma mark - 子类调用
// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
    //        NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor clearColor];
        // 适配 ios 11
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)createHeaderRefreshing
{
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadIsMore:NO];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)createFooterRefreshing
{
    WEAKSELF;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadIsMore:YES];
    }];
}

// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = NO;
    }else
    {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
    }
    [self loadMore:isMore];
}

// 结束刷新
- (void)endHeaderFooterRefreshing
{
    // 结束刷新状态
    ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
}


#pragma mark - 加载框
- (void)showLoading
{
    [SVProgressHUD showWithStatus:@"加载中..."];
}

- (void)dismissLoading
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
