//
//  BusinessInformationViewController.m
//  QFB
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "BusinessInformationViewController.h"
#import "NoDataView.h"
#import "ShopMessageTableViewCell.h"

@interface BusinessInformationViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataSource;
    NoDataView *_noDataView;
}
@end
@implementation BusinessInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户信息";
    
    [self requestData];
}
- (void)showNoDataViewWithTitle:(NSString *)title image:(NSString *)image isTap:(BOOL)isTap
{
    if (_noDataView) {
        [_noDataView initWithTitle:title image:image];
        return;
    }
    _noDataView = [NoDataView loadFromNib];
    [_noDataView initWithTitle:title image:image];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 58)];
    _tableView.tableFooterView = tableFooterView;
    if (isTap) {
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyMachine)];
        [tableFooterView addGestureRecognizer:myTap];
    }
    [_noDataView showNoDataViewOnView:tableFooterView];
}
- (void)buyMachine
{
    
}
- (void)removeNoDataView
{
    if (_noDataView) {
        _tableView.tableHeaderView  = [UIView new];
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}
-(void)requestData{
    WEAKSELF;
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"parent_id"] = [kDefault objectForKey:USER_IDk];
    parameter[@"realname"] = @"";
    parameter[@"pasmCode"] = @"";
    
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/psam/selectPosInformation.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            self->_dataSource = responseObject[@"data"];
            if ([(NSArray *)responseObject[@"data"] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showNoDataViewWithTitle:@"亲，您还没有商户哟！" image:@"no_msg_icon" isTap:NO];
                    [weakSelf.tableView reloadData];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableView.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopMessageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ShopMessageTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ShopMessageTableViewCell" owner:self options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
