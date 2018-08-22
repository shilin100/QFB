//
//  FriendUpgradeViewController.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "FriendUpgradeViewController.h"
#import "QFBHomeModel.h"
#import "FriendUpgradeViewCell.h"
#import "NoDataView.h"
#import "FriendUpgradeRuleViewController.h"

@interface FriendUpgradeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray * dataSource;

@property (nonatomic, strong) NoDataView * noDataView;

@property (nonatomic, strong)NSString *contentString;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *roleName;

@end

@implementation FriendUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"盟友升级";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestData];
}
-(void)requestData{
    WEAKSELF;
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"oBrandId"] = @"5109";
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/role/selectByoBrandId.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        NSArray * temp = [responseObject objectForKey:@"data"];
        if ([status isEqualToString:@"1"]) {
            
            if (temp.count == 0)
            {
                [weakSelf showNoDataViewWithTitle:@"不好意思，暂无可升级哟" image:@"no_msg_icon"];
                [weakSelf.tableView reloadData];
            }else
            {
                self.dataSource = [FriendUpgrade mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [weakSelf.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableView.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}
- (void)getDetailWithRoleId:(NSString *)roleId
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"roleId"] = roleId;
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/role/findRoleMessageByRoleId.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            FriendUpgradeRuleViewController * f_vc = [[FriendUpgradeRuleViewController alloc] init];
            f_vc.contentString = responseObject[@"data"][@"content"];
            f_vc.price = self->_price;
            f_vc.roleName = self->_roleName;
            [self.navigationController pushViewController:f_vc animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {
        
    }];
}
- (void)showNoDataViewWithTitle:(NSString *)title image:(NSString *)image
{
    if (_noDataView) {
        [_noDataView initWithTitle:title image:image];
        return;
    }
    _noDataView = [NoDataView loadFromNib];
    [_noDataView initWithTitle:title image:image];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 58)];
    _tableView.tableFooterView = tableFooterView;
    [_noDataView showNoDataViewOnView:tableFooterView];
}

- (void)removeNoDataView
{
    if (_noDataView) {
        _tableView.tableHeaderView  = [UIView new];
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendUpgradeViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FriendUpgradeViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"FriendUpgradeViewCell" owner:self options:nil]lastObject];
    }
    FriendUpgrade *temp = _dataSource[indexPath.row];
    [cell getDataWithModel:temp];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FriendUpgrade *temp = _dataSource[indexPath.row];
    _price = temp.price;
    _roleName = temp.roleName;
    [self getDetailWithRoleId:temp.id];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
