//
//  QFBMachineTransUsersController.m
//  QFB
//
//  Created by qqq on 2018/9/12.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMachineTransUsersController.h"

@interface QFBMachineTransUsersController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray<QFBUserModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<QFBUserModel *> *searchArray;
@end

@implementation QFBMachineTransUsersController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"机器转让";
    self.mySearchBar.delegate = self;
    self.myTableView.delegate = self;
    self.myTableView.dataSource= self;
    WEAKSELF;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData
{
    WEAKSELF;
    [self.netWorkTool net_getDirectFriendListBlockRequest:^(NSMutableArray<QFBUserModel *> *usersArray, RequestState state) {
        [weakSelf.myTableView.mj_header endRefreshing];
        if (state == net_succes) {
            weakSelf.dataArray = [NSMutableArray arrayWithArray:usersArray];
            weakSelf.searchArray = [NSMutableArray arrayWithArray:usersArray];
            [weakSelf.myTableView reloadData];
        }else{
            
        }
    }];
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DLog(@"searchText = %@",searchText);
    if ([searchText isEqualToString:@""]) {
        self.searchArray = [NSMutableArray arrayWithArray:self.dataArray];
        [self.myTableView reloadData];
        return ;
    }
    [self.searchArray removeAllObjects];
    for (QFBUserModel *model in self.dataArray) {
        if ([model.realName containsString:searchText] || [model.phone containsString:searchText]) {
            [self.searchArray addObject:model];
        }
    }
    [self.myTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *str = searchBar.text;
    if (str.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入商户名或机器编号"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if ([self.mySearchBar isFirstResponder]) {
        [self.mySearchBar resignFirstResponder];
    }
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.mySearchBar isFirstResponder]) {
        [self.mySearchBar resignFirstResponder];
        return ;
    }
    if (self.block) {
        self.block(self.searchArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"QFBMachineTransUsersControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.mj_size = CGSizeMake(50, 50);
    }
    QFBUserModel *model = self.searchArray[indexPath.row];
    cell.textLabel.text = model.realName;
    cell.detailTextLabel.text = model.phone;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.userPicture] placeholderImage:[UIImage imageNamed:@"userImage"]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.mySearchBar isFirstResponder]) {
        [self.mySearchBar resignFirstResponder];
    }
}

@end










