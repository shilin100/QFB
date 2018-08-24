//
//  QFBDrawMoneyController.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDrawMoneyController.h"
#import "QFBDrawMoneyCollectionView.h"
#import "QFBDrawMoneyBottomView.h"
#import "QFBDrawSuccessController.h"

@interface QFBDrawMoneyController ()

@property (nonatomic, strong) QFBDrawMoneyCollectionView *collectionView;   // 上部collectionView
@property (nonatomic, strong) QFBDrawMoneyBottomView     *bottomView;       //  整个下部视图
@property (nonatomic, strong) NSString *messageCode;
@property (nonatomic, strong) NSString *onlineMsg;
@property (nonatomic, strong) QFBDrawMoneyListModel *drawMoneyListModel;

@end

@implementation QFBDrawMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要提现";
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self loadUserByOnline];
    [self handleBlock];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTypeList];
}

- (void)handleBlock
{
    WEAKSELF;
    self.bottomView.pressSure = ^(BOOL isClick) {
        [weakSelf drawMoney];
    };
}


/**
 去取现
 */
- (void)drawMoney
{
    double willDrawMoney = [self.bottomView getMoney];
    double money = [self.collectionView getCanDrawMoney];
    if (![self.onlineMsg isEqualToString:@"1"]) {       // 重新登录
        [SVProgressHUD showInfoWithStatus:@"登录异常，请退出重新登录！"];
        [SVProgressHUD dismissWithDelay: 0.5];
        return ;
    }
    if (willDrawMoney < 10) {                           // 提现金额不能少于10元
        [SVProgressHUD showInfoWithStatus:@"提现金额不能少于10元"];
        [SVProgressHUD dismissWithDelay: 0.5];
        return ;
    }
    if (willDrawMoney > money) {                        // 提现金额 > 可提现金额
        [SVProgressHUD showInfoWithStatus:@"提现金额不能大于可提现金额"];
        [SVProgressHUD dismissWithDelay: 0.5];
        return ;
    }
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    //  先请求code
    [self loadMessageCode];
}


/**
 取现成功
 */
- (void)showSuccessViewControllerWithPrice:(NSString *)price name:(NSString *)name phone:(NSString *)phone
{
    QFBDrawSuccessController *vc = [[QFBDrawSuccessController alloc] init];
    vc.price = price;
    vc.name = name;
    vc.phone = phone;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求
- (void)loadTypeList
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/profit/getProfitByTx.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        NSLog(@"loadTypeList - %@",responseObject);
        QFBDrawMoneyListModel *listModel = [QFBDrawMoneyListModel mj_objectWithKeyValues:responseObject[@"data"]];
        [weakSelf.bottomView loadName:listModel.blackAccountName number:listModel.blackNum rate:listModel.rate];
        [weakSelf.collectionView loadDrawMoneyListModel:listModel];
        weakSelf.drawMoneyListModel = listModel;
    } andFaild:^(NSError *error) {
        
    }];
}

- (void)loadUserByOnline
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    dic[@"clientid"]  = [QFBTool getUUID];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/getUserByOnline.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        weakSelf.onlineMsg = responseObject[@"msg"];
    } andFaild:^(NSError *error) {
        
    }];
}

- (void)loadDrawMoney:(double)money
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = [kDefault objectForKey:USER_IDk];
    dic[@"price"]  = [NSString stringWithFormat:@"%g",money];
    dic[@"type"]   = [NSString stringWithFormat:@"%d",[self.collectionView getCurrentIndex]];
    dic[@"code"]   = self.messageCode;
    dic[@"clientid"] = [QFBTool getUUID];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/pay/zfbtx.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        NSLog(@"loadDrawMoney - %@",responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"提现成功"]) {
            [weakSelf showSuccessViewControllerWithPrice:[NSString stringWithFormat:@"%g",money] name:weakSelf.drawMoneyListModel.blackAccountName phone:weakSelf.drawMoneyListModel.blackNum];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            [SVProgressHUD dismissWithDelay: 0.5];
        }
        
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay: 0.5];
        // 测试用
//        [weakSelf showSuccessViewControllerWithPrice:[NSString stringWithFormat:@"%g",money] name:weakSelf.drawMoneyListModel.blackAccountName phone:weakSelf.drawMoneyListModel.blackNum];
    }];
}

- (void)loadMessageCode
{
    WEAKSELF;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/pay/txCode.action",BASEURL] withDic:dic Succeed:^(NSDictionary *responseObject) {
        weakSelf.messageCode = responseObject[@"data"];
        [weakSelf loadDrawMoney:[weakSelf.bottomView getMoney]];
    } andFaild:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay: 0.5];
    }];
}

#pragma mark - 懒加载
- (QFBDrawMoneyCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[QFBDrawMoneyCollectionView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, screen_width, 228)];
    }
    return _collectionView;
}

- (QFBDrawMoneyBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [QFBDrawMoneyBottomView initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), screen_width, screen_height - CGRectGetMaxY(self.collectionView.frame) - (SafeAreaBottomHeight - 49))];
    }
    return _bottomView;
}

@end







