//
//  QFBPersonalEarnViewController.m
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBPersonalEarnViewController.h"
#import "QFBPersonalEarnTableViewCell.h"
#import "QFBPersonalEarnModel.h"
#import "QFBPersonEarnTitleTableViewCell.h"

@interface QFBPersonalEarnViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *earnLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (assign, nonatomic) BOOL isExpand; //是否展开
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;//展开的cell的下标

@end

@implementation QFBPersonalEarnViewController{
    NSIndexPath *selectIndex;

}
static NSString * PersonalEarnTableViewCellIdentifier = @"QFBPersonalEarnTableViewCellIdentifier";
static NSString * PersonalEarnTitleCellIdentifier = @"QFBPersonalEarnTitleCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人收益";
    self.dataArray = [NSMutableArray array];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBPersonalEarnTableViewCell" bundle:nil] forCellReuseIdentifier:PersonalEarnTableViewCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBPersonEarnTitleTableViewCell" bundle:nil] forCellReuseIdentifier:PersonalEarnTitleCellIdentifier];

    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(-SafeAreaTopHeight, 0, 0, 0));
    }];
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.rowHeight = 40;
    [self requestData];

}

-(void)requestData{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/billDetailController/selectDirectlyByUserId.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[QFBPersonalEarnModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"maps"]]];
            [self handleData];
            self.earnLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"Allprofit"]];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
    
}

-(void)handleData{
    NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里；
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];

    
    self.yearLabel.text = [NSString stringWithFormat:@"%ld",(long)year];
    
    NSArray * temp = [NSArray arrayWithArray:self.dataArray];
    
    for (QFBPersonalEarnModel * model in temp) {
        if (model.month.integerValue > month) {
            [self.dataArray removeObject:model];
        }
    }
    
    [self.tableview reloadData];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
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
    if (_isExpand && [_selectedIndexPath isEqual:indexPath]) {//如果展开并且是当前选中的cell
        //创建扩展的cell
        QFBPersonalEarnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalEarnTableViewCellIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.layer.masksToBounds = YES;
        QFBPersonalEarnModel * model = self.dataArray[indexPath.row];
        [cell setCellWithModel:model];
        return cell;
        
    }else{     //普通情况
        //创建普通cell
        QFBPersonEarnTitleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalEarnTitleCellIdentifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.layer.masksToBounds = YES;
        QFBPersonalEarnModel * model = self.dataArray[indexPath.row];
        [cell setCellWithModel:model];
        return cell;
    }

    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 160 + (SafeAreaTopHeight - 64);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isExpand && self.selectedIndexPath == indexPath) {
        return 245;
    }
    return 40;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.selectedIndexPath) {
        self.selectedIndexPath = indexPath;
        self.isExpand = YES;
        [self.tableview beginUpdates];
        [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableview endUpdates];
    } else {
        if (self.isExpand) {
            if (self.selectedIndexPath == indexPath) {
                self.isExpand = NO;
                [self.tableview beginUpdates];
                [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableview endUpdates];
                self.selectedIndexPath = nil;
            } else {
                [self.tableview beginUpdates];
                [self.tableview reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                _isExpand = NO ;
                _selectedIndexPath = indexPath;
                _isExpand = YES ;
                [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableview endUpdates];
            }
        }
    }

}


@end
