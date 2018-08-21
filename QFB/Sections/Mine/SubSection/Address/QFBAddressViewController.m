//
//  QFBAddressViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAddressViewController.h"
#import "QFBAddressTableViewCell.h"
#import "QFBAddressModel.h"
#import "QFBAddAddressViewController.h"

@interface QFBAddressViewController ()
@property (strong, nonatomic)  NSMutableArray *dataArray;
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
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}
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

-(void)setDefaultWithId:(NSInteger)Id{
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"id"] = @(Id);
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

-(void)deleteWithId:(NSInteger)Id{
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"id"] = @(Id);
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/address/deleteAddress.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
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



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview.mj_header beginRefreshing];

}

-(void)clickAddBtn{
    QFBAddAddressViewController * vc = [QFBAddAddressViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self_weak_ setDefaultWithId:temp.ID];
    };
    cell.deleteBlock = ^(id model) {
        QFBAddressModel * temp = model;
        [self_weak_ deleteWithId:temp.ID];
    };
    cell.editBlock = ^(id model) {
        QFBAddressModel * temp = model;
        QFBAddAddressViewController * vc = [QFBAddAddressViewController new];
        [vc setVCEditStyleWithModel:temp];
        [self.navigationController pushViewController:vc animated:YES];
        
    };

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}





@end
