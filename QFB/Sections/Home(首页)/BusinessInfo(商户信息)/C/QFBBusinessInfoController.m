//
//  QFBBusinessInfoController.m
//  QFB
//
//  Created by qqq on 2018/9/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBusinessInfoController.h"
#import "QFBBusinessInfoCell.h"
#import "QFBBusinessDetailsController.h"

@interface QFBBusinessInfoController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<QFBBusinessInfoModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<QFBBusinessInfoModel *> *searchArray;
@property (nonatomic, strong) QFBNetWorkTool *netWorkTool;

@end

@implementation QFBBusinessInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"商户信息";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.netWorkTool = [[QFBNetWorkTool alloc] init];
    [self loadDataRealname:nil pasmCode:nil];
}

- (void)loadDataRealname:(NSString *)name pasmCode:(NSString *)pasmCode
{
    WEAKSELF;
    [self.netWorkTool net_searchShopMessageRealname:name pasmCode:pasmCode blockRequest:^(NSMutableArray<QFBBusinessInfoModel *> *modelArray, RequestState state) {
        weakSelf.dataArray = [NSMutableArray arrayWithArray:modelArray];
        weakSelf.searchArray = [NSMutableArray arrayWithArray:modelArray];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DLog(@"searchText = %@",searchText);
    if ([searchText isEqualToString:@""]) {
        self.searchArray = [NSMutableArray arrayWithArray:self.dataArray];
        [self.tableView reloadData];
        return ;
    }
    [self.searchArray removeAllObjects];
    for (QFBBusinessInfoModel *model in self.dataArray) {
        if ([model.psamCode containsString:searchText] || [model.remarks containsString:searchText]) {
            [self.searchArray addObject:model];
        }
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *str = searchBar.text;
    if (str.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入商户名或机器编号"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QFBBusinessDetailsController *vc = [[QFBBusinessDetailsController alloc] init];
    vc.myPsamCode = self.searchArray[indexPath.row].psamCode;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QFBBusinessInfoCell initWithTableView:tableView model:self.searchArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


@end









