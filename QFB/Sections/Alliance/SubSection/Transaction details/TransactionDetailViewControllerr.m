//
//  TransactionDetailViewControllerr.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "TransactionDetailViewControllerr.h"
#import "NoDataView.h"
#import "AllianceModel.h"
#import "DetailTableViewCell.h"

@interface TransactionDetailViewControllerr ()

@property (strong, nonatomic) NSArray * dataSource;

@property (nonatomic, strong) NoDataView * noDataView;

@end

@implementation TransactionDetailViewControllerr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"交易明细";
    [self getTransactionList];
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
#pragma mark - service
- (void)getTransactionList
{
    WEAKSELF;
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/transaction/getTransactionListByUserId.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        NSArray * temp = [responseObject objectForKey:@"data"];
        if ([status isEqualToString:@"1"]) {
            
            if (temp.count == 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showNoDataViewWithTitle:@"暂无交易明细" image:@"no_msg_icon"];
                    [weakSelf.tableView reloadData];
                });
            }else
            {
                self.dataSource = [TransactionDetail mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"DetailTableViewCell" owner:self options:nil]lastObject];
    }
    TransactionDetail *temp = _dataSource[indexPath.row];
    [cell getTranscationDetailDataWithModel:temp];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
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
