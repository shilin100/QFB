//
//  QFBAccountViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAccountViewController.h"
#import "QFBAccountTableViewCell.h"
#import "QFBAccountTextTableViewCell.h"
#import "QFBAccountHeadView.h"
#import "QFBLoginViewController.h"

@interface QFBAccountViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (strong, nonatomic)  NSArray *headArray;

@end

@implementation QFBAccountViewController
static NSString * AccountTableViewCellIdentifier = @"AccountTableViewCellIdentifier";
static NSString * AccountTextTableViewCellIdentifier = @"AccountTextTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"品牌收益";
    self.dataArray = [NSMutableArray arrayWithArray:@[@[@{@"title":@"头像"},@{@"title":@"昵称",@"detail":[kDefault objectForKey:NICK_NAMEk]}],
                                                      @[@{@"title":@"真实姓名",@"detail":[kDefault objectForKey:USER_REALNAMEk]},@{@"title":@"证件号码",@"detail":[kDefault objectForKey:USER_IDCARDk]}],
                                                      @[@{@"title":@"真实姓名",@"detail":[kDefault objectForKey:ALIPAY_NAMEk]},@{@"title":@"支付宝账号",@"detail":[kDefault objectForKey:ALIPAY_ACCOUNTk]}]]];
    
    self.headArray = @[@"个人资料",@"商户信息",@"支付宝账号信息"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAccountTableViewCell" bundle:nil] forCellReuseIdentifier:AccountTableViewCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAccountTextTableViewCell" bundle:nil] forCellReuseIdentifier:AccountTextTableViewCellIdentifier];

//    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    self.tableview.tableFooterView = [UIView new];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (IBAction)logoutBtnAction:(id)sender {
    NSString * username = [kDefault objectForKey:USERNAMEk];
    NSString * psw = [kDefault objectForKey:PASSWORDk];
    BOOL isFirstTouch = [kDefault boolForKey:IS_FIRST_TOUCH];

    NSDictionary * dict = [kDefault dictionaryRepresentation];
    
    for (id key in dict) {
        
        [kDefault removeObjectForKey:key];
        
    }
    
    [kDefault synchronize];
    [kDefault setObject:username forKey:USERNAMEk];
    [kDefault setObject:psw forKey:PASSWORDk];
    [kDefault setBool:isFirstTouch forKey:IS_FIRST_TOUCH];

    QFBLoginViewController *vc = [[QFBLoginViewController alloc] init];
    QFBBaseNaviViewController * loginNav = [[QFBBaseNaviViewController alloc]initWithRootViewController:vc];
    APPLication.keyWindow.rootViewController = loginNav;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * temp = self.dataArray[section];
    
    return temp.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QFBAccountTableViewCell * cell;
    NSDictionary * temp = self.dataArray[indexPath.section][indexPath.row];

    if (indexPath.section == 0 && indexPath.row == 0) {
       cell = [tableView dequeueReusableCellWithIdentifier:AccountTableViewCellIdentifier forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:[kDefault objectForKey:USER_HEAD_IMGk]] placeholderImage:[UIImage imageNamed:@"登录页默认头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        cell.mytitile.text = temp[@"title"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }else{
        QFBAccountTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AccountTextTableViewCellIdentifier forIndexPath:indexPath];
        cell.mydetail.text = temp[@"detail"];
        cell.mytitile.text = temp[@"title"];

        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QFBAccountHeadView * headview = [[QFBAccountHeadView alloc]init];
    headview.titleLabel.text = self.headArray[section];
    return headview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    } else
        return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}















@end
