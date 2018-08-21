//
//  WantMachineViewController.m
//  QFB
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "WantMachineViewController.h"
#import "BuyMachineTableViewCell.h"
#import "NoDataView.h"

@interface WantMachineViewController ()

@property (strong, nonatomic) NSArray * dataSource;

@property (nonatomic, strong) NoDataView * noDataView;

@end

@implementation WantMachineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我要机器";
    [self requestData];
}
//获取机器列表
-(void)requestData{
    WEAKSELF;
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/posType/posTypeList.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        NSArray * temp = [responseObject objectForKey:@"data"];
        if ([status isEqualToString:@"1"]) {
            if (temp.count == 0)
            {
                weakSelf.bottomView.hidden = YES;
                [weakSelf showNoDataViewWithTitle:@"不好意思，暂无可购买的机器哟" image:@"no_msg_icon"];
                [weakSelf.tableView reloadData];
            }else
            {
                weakSelf.bottomView.hidden = NO;
                self.dataSource = [BuyMachine mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return 107;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BuyMachine* model=self.dataSource[indexPath.row];
    BuyMachineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BuyMachineTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BuyMachineTableViewCell" owner:self options:nil]lastObject];
    }
    NSLog(@"%@",model.remarksTwo);
    [cell getDataWithModel:model index:indexPath.row count:_dataSource.count];
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
