//
//  QFBAddAddressViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAddAddressViewController.h"
#import "QFBAddAddressTableViewCell.h"
#import "CZHAddressPickerView.h"
#import "QFBAddressModel.h"

@interface QFBAddAddressViewController (){
    NSString *ID;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (strong, nonatomic)  NSMutableArray *placeholderArray;

@end

@implementation QFBAddAddressViewController
static NSString * AddAddressTableViewCellIdentifier = @"AddAddressTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
        self.placeholderArray = [NSMutableArray arrayWithArray:@[@"请输入收货人姓名",@"请输入收货人手机号",@"选择所在地区",@"请输入详细地址"]];
    }
    
    if (self.addressType == TYPE_OTHER) {
        self.addressType = TYPE_ADD;
        self.navigationItem.title = @"添加收货地址";
    }
    
    UIBarButtonItem * addButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickSaveBtn)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAddAddressTableViewCell" bundle:nil] forCellReuseIdentifier:AddAddressTableViewCellIdentifier];
    self.tableview.tableFooterView = [UIView new];
}

#pragma mark - 保存收货地址
-(void)clickSaveBtn{
    NSMutableArray * cells = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        QFBAddAddressTableViewCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cells addObject:IS_STR_EMPTY(cell.input.text) ? @"" : cell.input.text];
    }
    NSString * name = cells[0];
    NSString * tel = cells[1];
    NSString * area = cells[2];
    NSString * address = cells[3];
    if (![RegularHelperUtil checkTelNumber:tel]) {
        [SVProgressHUD showErrorWithStatus:@"手机号有误"];
        return;
    }
    if (IS_STR_EMPTY(name) || IS_STR_EMPTY(tel) || IS_STR_EMPTY(area) || IS_STR_EMPTY(address)) {
        [SVProgressHUD showErrorWithStatus:@"请填写完整信息"];
        return;
    }

    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"phone"] = tel;
    parameter[@"name"] = name;
    parameter[@"address"] = [NSString stringWithFormat:@"%@-%@",area,address];

    NSString * url;
    if (self.addressType == TYPE_EDIT) {    // 编辑修改地址
        url =@"/address/updateAddress.action";
        parameter[@"id"] = ID;
    }else{                                  // 添加地址
        url = @"/address/addAddress.action";
    }
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@%@",BASEURL,url] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];

}


-(void)setVCEditStyleWithModel:(QFBAddressModel*)model{
    self.navigationItem.title = @"编辑收货地址";
    NSString * addressStr = model.address;
    NSArray *addressArray = [addressStr componentsSeparatedByString:@"-"];
    self.dataArray = [NSMutableArray arrayWithArray:@[model.name,model.phone,addressArray.firstObject,addressArray.lastObject]];
    self.addressType = TYPE_EDIT;
    ID = model.ID;
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
    QFBAddAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddAddressTableViewCellIdentifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (self.addressType == TYPE_EDIT) {
        cell.input.text = self.dataArray[indexPath.row];
    }
    cell.input.placeholder = self.placeholderArray[indexPath.row];
    if (indexPath.row == 2) {
        cell.input.userInteractionEnabled = NO;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [CZHAddressPickerView areaPickerViewWithAreaBlock:^(NSString *province, NSString *city, NSString *area) {
            QFBAddAddressTableViewCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.input.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        }];
    }

}

@end
