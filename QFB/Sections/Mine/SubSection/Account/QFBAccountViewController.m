//
//  QFBAccountViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAccountViewController.h"
#import "QFBAccountTableViewCell.h"

@interface QFBAccountViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (strong, nonatomic)  NSMutableArray *dataArray;

@end

@implementation QFBAccountViewController
static NSString * AccountTableViewCellIdentifier = @"AccountTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"品牌收益";
    self.dataArray = [NSMutableArray array];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAccountTableViewCell" bundle:nil] forCellReuseIdentifier:AccountTableViewCellIdentifier];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QFBAccountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AccountTableViewCellIdentifier forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    } else
        return 44;
}
















@end
