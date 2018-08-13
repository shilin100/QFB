//
//  QFBUpgradeRuleViewController.m
//  QFB
//
//  Created by qqq on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBUpgradeRuleViewController.h"
#import "QFBUpgradeRuleTableViewCell.h"

@interface QFBUpgradeRuleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation QFBUpgradeRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    
    
}

-(void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.tableView.delegate               = self;
    self.tableView.dataSource             = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"QFBUpgradeRuleTableViewCell" bundle:nil] forCellReuseIdentifier:upgradeTableViewCellIdentifier];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
static NSString * upgradeTableViewCellIdentifier = @"upgradeRuleTableViewCellIdentifier";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QFBUpgradeRuleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:upgradeTableViewCellIdentifier forIndexPath:indexPath];

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;

}







@end
