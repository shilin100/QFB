//
//  QFBAddressViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAddressViewController.h"
#import "QFBAddressTableViewCell.h"
#import "QFBAddAddressViewController.h"

@interface QFBAddressViewController ()
@property (strong, nonatomic)  NSMutableArray<QFBAddressModel *> *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation QFBAddressViewController
static NSString * AddressTableViewCellIdentifier = @"AddressTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收货地址";
    self.dataArray = [NSMutableArray array];
    
    UIBarButtonItem * addButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(clickAddBtn)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAddressTableViewCell" bundle:nil] forCellReuseIdentifier:AddressTableViewCellIdentifier];
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    WEAKSELF;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview.mj_header beginRefreshing];
    
}

#pragma mark - 请求地址数据源
-(void)requestData{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/address/selectAddress.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[QFBAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            [self.tableview reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
    
}

#pragma mark - 设置默认地址
-(void)setDefaultWithId:(NSString *)Id{
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"id"] = Id;
    parameter[@"defaultAddress"] = @0;
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/address/updateAddress.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.tableview.mj_header beginRefreshing];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
    
}

#pragma mark - 删除地址
-(void)deleteWithId:(NSString *)addressId
{
    WEAKSELF;
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认删除该收货地址吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf deleteAddressWithAddressId:addressId];
    }];
    [alertCtrl addAction:cancelAction];
    [alertCtrl addAction:continueAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

- (void)deleteAddressWithAddressId:(NSString *)Id
{
//    WEAKSELF;
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"id"] = Id;
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/address/deleteAddress.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            if (self.blockAddress && [self.addressID isEqualToString:Id]) {
                self.blockAddress(nil);
            }
            [self.tableview.mj_header beginRefreshing];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
}

#pragma mark - 添加地址
-(void)clickAddBtn{
    QFBAddAddressViewController * vc = [QFBAddAddressViewController new];
    vc.addressType = TYPE_ADD;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockAddress) {
        self.blockAddress(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QFBAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressTableViewCellIdentifier forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    QFBAddressModel * model = self.dataArray[indexPath.row];
    [cell setCellWithModel:model];
    @weakify(self)
    cell.setDefultBlock = ^(id model) {
        QFBAddressModel * temp = model;
        [self_weak_ setDefaultWithId: temp.ID];
    };
    cell.deleteBlock = ^(id model) {
        QFBAddressModel * temp = model;
        [self_weak_ deleteWithId: temp.ID];
    };
    cell.editBlock = ^(id model) {
        QFBAddressModel * temp = model;
        QFBAddAddressViewController * vc = [QFBAddAddressViewController new];
        [vc setVCEditStyleWithModel:temp];
        [self_weak_.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)dealloc
{
    logDealloc;
}

@end





