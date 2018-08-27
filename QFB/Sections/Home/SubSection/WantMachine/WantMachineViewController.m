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
#import "QFBDistributionController.h"

@interface WantMachineViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label_bottom;
@property (strong, nonatomic) NSMutableArray<BuyMachine *> *dataSource;
@property (nonatomic, strong) NoDataView * noDataView;
@property (nonatomic, assign) BOOL isFirstGetMachines;  // 是否是第一次领取机器
@property (nonatomic, assign) BOOL isHasOrder;          // 是否有未完成的订单
@property (nonatomic, assign) int  everyTimeNumber;     // 每次免费领取数量
@property (nonatomic, assign) int  firstTimeNumber;     // 第一次免费领取数量

@property (nonatomic, assign) int  selectorCount;       // 选择的总数量
@property (nonatomic, assign) float selectorPrice;      // 选择的总价格

@end

@implementation WantMachineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.title = @"我要机器";
    [self requestData];     // 加载数据
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self judgeUserIsFirstGetMachines]; // 判断是否是第一次领取
}

#pragma mark - 调用的方法

- (IBAction)pressPay:(id)sender {
    [self preeSureBuy];
}

/**
 确认购买
 */
- (void)preeSureBuy
{
    NSMutableArray <BuyMachine *> *array = [NSMutableArray array];
    for (BuyMachine *model in self.dataSource) {
        if (model.selectorCount > 0) {
            [array addObject:model];
        }
    }
    if (array.count == 0) {  // 没有选择机器
        [SVProgressHUD showInfoWithStatus:@"亲，请添加您要购买的机器"];
        [SVProgressHUD dismissWithDelay:0.5];
        return ;
    }
    if (self.isHasOrder) {    // 要是有未完成的订单不能继续免费下单
        [SVProgressHUD showInfoWithStatus:@"您还有尚未完成订单，不能够免费领取机器"];
        [SVProgressHUD dismissWithDelay:0.5];
        return ;
    }
    if (array.count > 5) {    // 最多可以选择5种机器
        [SVProgressHUD showInfoWithStatus:@"亲，单次最多可以选择5种机器"];
        [SVProgressHUD dismissWithDelay:0.5];
        return ;
    }
    if (self.isFirstGetMachines) {      // 第一次免费领取
        if (self.selectorCount > self.firstTimeNumber) {    // 领取的超过免费数
            NSString *showStr = [NSString stringWithFormat:@"您目前每次只能免费领取%d台",self.firstTimeNumber];
            [SVProgressHUD showInfoWithStatus:showStr];
            [SVProgressHUD dismissWithDelay:0.5];
        }else{
            [self getDefaultAddress:YES];
        }
        return ;
    }
    // 后面领取的
    if (self.selectorCount > self.everyTimeNumber) {
        if (self.everyTimeNumber != 0) {
            NSString *showStr = [NSString stringWithFormat:@"您目前每次只能免费领取%d台",self.everyTimeNumber];
            [SVProgressHUD showInfoWithStatus:showStr];
            [SVProgressHUD dismissWithDelay:0.5];
        }else{              // 没有免费名额 全部出钱买
            [self getDefaultAddress:NO];
        }
    }else{
        [self getDefaultAddress:YES];
    }
//    getActiveCount    返回 数量
}

#pragma mark - 网络请求

/**
 获取默认地址 isFree: 是否免费
 */
- (void)getDefaultAddress:(BOOL)isFree
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/address/findDefault.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        QFBDistributionController *cv = [[QFBDistributionController alloc] init];
        QFBDistributionModel *model = [[QFBDistributionModel alloc] init];
        model.addressModel = [QFBAddressModel mj_objectWithKeyValues:responseObject[@"data"]];
        model.number = weakSelf.selectorCount;
        model.price = isFree ? 0 : weakSelf.selectorPrice;
        model.addressType = @"普通快递";
        model.addressTime = @"7个工作日内安排发货";
        cv.distributionModel = model;
        [weakSelf.navigationController pushViewController:cv animated:YES];
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络出错"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}

/**
 获取是否是第一次免费领取
 */
- (void)judgeUserIsFirstGetMachines
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/psam/getAllPsamByUserId.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        NSString *str = responseObject[@"data"];
        if ([@"0" isEqualToString:str]) {
            weakSelf.isFirstGetMachines = YES;  // 第一次免费领取
        }else{
            weakSelf.isFirstGetMachines = NO;   //
        }
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络出错"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}

/**
 获取免费领取机器数
 */
- (void)getFreeMachinesCount
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    dic[@"roleId"]    = [kDefault objectForKey:ROLE_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/role/findById.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        NSString *remarksString = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"remarks"]];
        NSString *reserveString = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"reserve"]];
        NSString *reserveOneString = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"reserveOne"]];
        weakSelf.isHasOrder      = [reserveOneString intValue]; // 是否有订单
        weakSelf.firstTimeNumber = [reserveString intValue];    // 第一次免费领取个数    b
        weakSelf.everyTimeNumber = [remarksString intValue];    // 每次免费领取个数      a
    } andFaild:^(NSError *error) {
        
    }];
}

/**
 获取机器列表
 */
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

#pragma mark - 没数据时
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
    return 108;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyMachine* model=self.dataSource[indexPath.row];
    BuyMachineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BuyMachineTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"BuyMachineTableViewCell" owner:self options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell getDataWithModel:model];
    WEAKSELF;
    cell.buttonClick = ^(BOOL isClick) {
        int allCount = 0;
        double allPrice = 0;
        for (BuyMachine *model in weakSelf.dataSource) {
            if (model.selectorCount > 0) {
                allCount += model.selectorCount;
                allPrice += (model.selectorCount * model.price);
            }
        }
        weakSelf.selectorCount = allCount;
        weakSelf.selectorPrice = allPrice;
        weakSelf.label_bottom.text = [NSString stringWithFormat:@"共领用 %d 台，总价 %g 元",allCount, allPrice];
    };
    return cell;
}

@end









