//
//  AccounMessageViewController.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "AccounMessageViewController.h"
#import "AccounMessageCell.h"
#import <FBFramework/FBFramework.h>
#import "ConfirmPersonViewController.h"
#import "ConfirmAlipayViewController.h"

@interface AccounMessageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic)  NSMutableArray *dataArray;

@end

@implementation AccounMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"实名认证";
    self.dataArray = [NSMutableArray array];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-SafeAreaTopHeight, 0, 0, 0));
    }];
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //[self requestData];
//    }];
//    [self.tableview.mj_header beginRefreshing];
    [self initUI];
    
}
#pragma mark - UI
- (void)initUI
{
    if ([VerifyHelper isEmpty:[kDefault objectForKey:NICK_NAMEk]]) {
        _nameLabel.text = [kDefault objectForKey:NICK_NAMEk];
    } else {
        _nameLabel.text = [kDefault objectForKey:USER_REALNAMEk];
    }
    if ([VerifyHelper isEmpty:[kDefault objectForKey:USER_IDCARDk]]) {
        _topCardImageView.image = [UIImage imageNamed:@"unconfirm_person_icon"];
        _cardNumLabel.text = @"******************";
    } else {
        _topCardImageView.image = [UIImage imageNamed:@"big_real_name"];
        NSString *str1 = [[kDefault objectForKey:USER_IDCARDk] substringToIndex:3];
        NSString *str2 = [[kDefault objectForKey:USER_IDCARDk] substringFromIndex:15];
        _cardNumLabel.text = [NSString stringWithFormat:@"%@************%@",str1,str2];
    }
    if ([VerifyHelper isEmpty:[kDefault objectForKey:ALIPAY_ACCOUNTk]]) {
        _topAliPayImageView.image = [UIImage imageNamed:@"unconfirm_alipay_icon"];
        _aliPayAccountLabel.text = @"***********";
    } else {
        _topAliPayImageView.image = [UIImage imageNamed:@"confirm_alipay_icon"];
        NSString *str1 = [[kDefault objectForKey:ALIPAY_ACCOUNTk] substringToIndex:3];
        NSString *str2 = [[kDefault objectForKey:ALIPAY_ACCOUNTk] substringFromIndex:[[kDefault objectForKey:ALIPAY_ACCOUNTk] length] - 3];
        _aliPayAccountLabel.text = [NSString stringWithFormat:@"%@*******%@",str1,str2];
    }
    if ([VerifyHelper isEmpty:[kDefault objectForKey:USER_IDCARDk]] || [VerifyHelper isEmpty:[kDefault objectForKey:ALIPAY_ACCOUNTk]]) {
        _yeahImageView.alpha = 0;
    } else {
        _yeahImageView.alpha = 1;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AccounMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AccounMessageCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AccounMessageCell" owner:self options:nil]lastObject];
    }
    if (indexPath.section == 0) {
        cell.img.image = [UIImage imageNamed:@"small_person_icon"];
        cell.lab.text = @"身份证认证";
    }else
    {
        cell.img.image = [UIImage imageNamed:@"gray_alipay_icon"];
        cell.lab.text = @"支付宝认证";
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.headView;
    }else
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 280;
    }else
        return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ConfirmPersonViewController * c_vc = [[ConfirmPersonViewController alloc] init];
        [self.navigationController pushViewController:c_vc animated:YES];
    }else
    {
        ConfirmAlipayViewController * c_vc = [[ConfirmAlipayViewController alloc] init];
        [self.navigationController pushViewController:c_vc animated:YES];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[QFBResourcesTool tool_getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
