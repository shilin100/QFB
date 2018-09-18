//
//  FriendContactViewController.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "FriendContactViewController.h"
#import "QFBFriendContactCell.h"
#import "QFBFriendPopView.h"

@interface FriendContactViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearch;
@property (weak, nonatomic) IBOutlet UIImageView *image_user;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UIButton *button_friend;

@property (nonatomic, strong) NSMutableArray<QFBUserModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<QFBUserModel *> *searchArray;
@property (nonatomic, strong) NSMutableArray<QFBRoleModel *> *roleArray;
@property (nonatomic, strong) NSString *myCard;
@property (nonatomic, strong) NSString *myRole;
@property (nonatomic, strong) NSString *mySearchName;
@property (nonatomic, strong) NSString *myRecommendManPhone;
@property (nonatomic, weak) QFBFriendPopView *popview;

@end

@implementation FriendContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"盟友通讯";
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.mySearch.delegate = self;
    [self loadFriendData];
    [self createHeaderRefreshing];
}

#pragma mark - 下拉刷新调用
- (void)loadRefresh
{
    [self getFriendList];   // 加载盟友列表
}

// 获取盟友
- (void)getFriendList
{
    WEAKSELF;
    [self.netWorkTool net_getFriendBooksWithUserId:[kDefault objectForKey:USER_IDk] card:_myCard roleId:_myRole realName:_mySearchName blockRequest:^(NSMutableArray<QFBUserModel *> *usersArray, RequestState state) {
        [weakSelf.myTableView.mj_header endRefreshing];
        if (state == net_succes) {
            weakSelf.dataArray = [NSMutableArray arrayWithArray:usersArray];
            weakSelf.searchArray = [NSMutableArray arrayWithArray:usersArray];
            [weakSelf.myTableView reloadData];
        }
    }];
}

#pragma mark - 网络数据请求
- (void)loadFriendData
{
    [self getRecommendMan]; // 获取推荐人
    [self getAllRole];      // 获取所有角色
}

// 获取推荐人
- (void)getRecommendMan
{
    WEAKSELF;
    [self.netWorkTool net_getUserInfoWithUserID:[PublicData sharePublic].userModel.parentId blockRequest:^(QFBUserModel *model, RequestState state) {
        weakSelf.myRecommendManPhone = model.phone;
        if (LMJIsEmpty(model.realName)) {
            weakSelf.label_name.text = @"普通用户";
        }else{
            weakSelf.label_name.text = model.realName;
        }
    }];
}

// 获取所有角色
- (void)getAllRole
{
    WEAKSELF;
    [self.netWorkTool net_getAllFriendsRoleBlockRequest:^(NSMutableArray<QFBRoleModel *> *roleArray, RequestState state) {
        weakSelf.roleArray = roleArray;
    }];
}

#pragma mark - 点击事件
// 点击phone
- (IBAction)pressPhone:(id)sender {
    if (LMJIsEmpty(self.myRecommendManPhone)) {
        [SVProgressHUD showInfoWithStatus:@"您的导师尚未完善手机号"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    UIWebView * callWebview = [[UIWebView alloc]init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.myRecommendManPhone]]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}
//  点击全部盟友
- (IBAction)pressFriend:(id)sender {
//    QFBFriendPopView
    if (_popview) {
        [_popview removeFromSuperview];
    }else{
        WEAKSELF;
        QFBFriendPopView *pv = [[QFBFriendPopView alloc] initWithFrame:self.myTableView.frame roles:self.roleArray];
        pv.block = ^(id obj) {
            if ([obj isKindOfClass:[QFBRoleModel class]]) {
                 QFBRoleModel *model = obj;
                weakSelf.myRole = model.ID;
                weakSelf.myCard = @"";
                weakSelf.mySearchName = @"";
                [weakSelf.button_friend setTitle:model.roleName forState:UIControlStateNormal];
//                [weakSelf.button_friend setNeedsLayout];
            }else{
                weakSelf.myRole = @"";
                weakSelf.mySearchName = @"";
                if ([@"全部盟友" isEqualToString:obj]) {
                    weakSelf.myCard = @"";
                }else if ([@"已实名" isEqualToString:obj]){
                    weakSelf.myCard = @"1";
                }else{                          // 未实名
                    weakSelf.myCard = @"-1";
                }
                [weakSelf.button_friend setTitle:obj forState:UIControlStateNormal];
//                [weakSelf.button_friend setNeedsLayout];
            }
            [weakSelf.myTableView.mj_header beginRefreshing];
        };
        [self.view addSubview:pv];
        _popview = pv;
    }
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
        if ([model.phone containsString:searchText] || [model.realName containsString:searchText]) {
            [self.searchArray addObject:model];
        }
    }
    [self.myTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *str = searchBar.text;
    if (str.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入好友姓名或手机号"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (self.mySearch.isFirstResponder) {
        [self.mySearch resignFirstResponder];
    }
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QFBFriendContactCell initWithTableView:tableView model:self.searchArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)createHeaderRefreshing
{
    WEAKSELF;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadRefresh];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)dealloc
{
    logDealloc;
}

@end








