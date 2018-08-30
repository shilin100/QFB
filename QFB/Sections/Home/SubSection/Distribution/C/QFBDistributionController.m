//
//  QFBDistributionController.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionController.h"
#import "QFBDistributionCell.h"
#import "QFBDistributionHeaderView.h"
#import "QFBDistributionFootView.h"
#import "QFBPaymentController.h"

@interface QFBDistributionController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QFBDistributionHeaderView *headerView;
@property (nonatomic, strong) QFBDistributionFootView *footView;
@property (nonatomic, strong) NSMutableArray<QFBDistributionCellModel *> *arrayCellModels;  // cell model
@property (nonatomic, strong) QFBDistributionModel *distributionModel;      //  界面 model

@end

@implementation QFBDistributionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"配送至";
    [self.view addSubview:self.tableView];
    [self loadBlock];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadAddressData];
}

#pragma mark - 网络请求
- (void)loadAddressData
{
    if (self.distributionModel.addressModel) {
        return ;
    }
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/address/findDefault.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        weakSelf.distributionModel.addressModel = [QFBAddressModel mj_objectWithKeyValues:responseObject[@"data"]];
        [weakSelf.headerView loadAddressModel:weakSelf.distributionModel.addressModel];
        [weakSelf.tableView reloadData];
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络出错"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}


- (void)payOrder
{
    if (![self.headerView getSelelctorAddress]) {
        [SVProgressHUD showInfoWithStatus:@"请添加收货地址"];
        [SVProgressHUD dismissWithDelay:0.5];
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    dic[@"adress"]    = [self.headerView getSelelctorAddress].ID;
    dic[@"note"]      = [self.footView getNote];
    if (self.distributionModel.price > 0) { // 免费的传空  不免费的传1
        dic[@"remarksOne"]  = @"1";
    }
    NSArray *keyArray = @[@"typeNum",@"typeNumTwo",@"typeNumThree",@"typeNumFour",@"typeNumFive"];
    for (int i = 0; i < self.productsArray.count; i++) {
        dic[keyArray[i]] = [NSString stringWithFormat:@"%@/%d",self.productsArray[i].remarks, self.productsArray[i].selectorCount];
    }
    WEAKSELF;
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/posReceive/addReceive.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"1"]) {
            if (weakSelf.isFree) {      // 免费 直接跳成功控制器
                
            }else{                      // 要付钱 跳支付页面
                QFBPaymentController *vc = [[QFBPaymentController alloc] init];
                vc.amountOfPayment = weakSelf.distributionModel.price;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络出错"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
}

#pragma mark - block
- (void)loadBlock
{
    WEAKSELF;
    // 点击确认支付
    self.footView.block = ^(BOOL isClick) {
        [weakSelf payOrder];
    };
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCellModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QFBDistributionCell initWithTableView:tableView model:self.arrayCellModels[indexPath.row]];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footView;
    }
    return _tableView;
}

- (QFBDistributionHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [QFBDistributionHeaderView initWithFrame:CGRectMake(0, 0, screen_width, 80) model:self.distributionModel.addressModel];
    }
    return _headerView;
}

- (QFBDistributionFootView *)footView
{
    if (!_footView) {
        _footView = [QFBDistributionFootView initWithFrame:CGRectMake(0, 0, screen_width, 100)];
        [_footView changeBtnTitleState:self.distributionModel.price];
    }
    return _footView;
}

- (NSMutableArray<QFBDistributionCellModel *> *)arrayCellModels
{
    if (!_arrayCellModels) {
        _arrayCellModels = [NSMutableArray array];
        QFBDistributionCellModel *model0 = [QFBDistributionCellModel initWithLeft:@"数量" right:[NSString stringWithFormat:@"%d",self.distributionModel.number]];
        QFBDistributionCellModel *model1 = [QFBDistributionCellModel initWithLeft:@"金额" right:[NSString stringWithFormat:@"%g",self.distributionModel.price]];
        QFBDistributionCellModel *model2 = [QFBDistributionCellModel initWithLeft:@"配送方式" right:@"普通快递"];
        QFBDistributionCellModel *model3 = [QFBDistributionCellModel initWithLeft:@"数量" right:@"7个工作日内安排发货"];
        [_arrayCellModels addObject:model0];
        [_arrayCellModels addObject:model1];
        [_arrayCellModels addObject:model2];
        [_arrayCellModels addObject:model3];
    }
    return _arrayCellModels;
}

- (QFBDistributionModel *)distributionModel
{
    if (!_distributionModel) {
        _distributionModel = [[QFBDistributionModel alloc] init];
        int selectorCount = 0;
        double selectorPrice = 0;
        for (BuyMachine *model in self.productsArray) {
            selectorCount += model.selectorCount;
            selectorPrice += (model.price * model.selectorCount);
        }
        _distributionModel.number = selectorCount;
        _distributionModel.price = self.isFree ? 0 : selectorPrice;
        _distributionModel.addressType = @"普通快递";
        _distributionModel.addressTime = @"7个工作日内安排发货";
    }
    return _distributionModel;
}

@end







