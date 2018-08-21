//
//  QFBMyOrderViewController.m
//  QFB
//
//  Created by qqq on 2018/8/17.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMyOrderViewController.h"
#import "QFBOrderTableViewCell.h"
#import "OrderModel.h"
#import "WantMachineViewController.h"

@interface QFBMyOrderViewController ()<UITextFieldDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *segmentContent;

@property (strong, nonatomic)  HMSegmentedControl *segmentView;


@end

@implementation QFBMyOrderViewController
{
    NSArray * orderStatus;
}
static NSString * orderTableViewCellIdentifier = @"OrderTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    orderStatus =@[@"全部",@"待付款",@"待发货",@"已发货"];
    [self creatSegment];
    self.navigationItem.title = @"我的订单";
    self.searchTextField.delegate = self;
    
    self.dataArray = [NSMutableArray array];
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBOrderTableViewCell" bundle:nil] forCellReuseIdentifier:orderTableViewCellIdentifier];

    self.tableview.tableFooterView = [UIView new];
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;

//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.rowHeight = 40;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.searchTextField.text = @"";
        [self requestData];
    }];
    [self.tableview.mj_header beginRefreshing];

}

-(void)requestData{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    switch (self.segmentView.selectedSegmentIndex) {
        case 1:
            parameter[@"status"] = @2;
            break;
        case 2:
            parameter[@"status"] = @0;
            break;
        case 3:
            parameter[@"status"] = @1;
            break;

        default:
            break;
    }
    
    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/posReceive/findPosReceveById.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            [self.tableview reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
    
}


-(void)creatSegment{
    
    
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:orderStatus];
    segmentedControl.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 28);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    //    segmentedControl.verticalDividerEnabled = YES;
    //    segmentedControl.verticalDividerColor = RGBCOLOR(235, 235, 235);
    //    segmentedControl.verticalDividerWidth = 1.0f;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName : XFont(14),NSForegroundColorAttributeName : [UIColor blackColor]};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName : XFont(14),NSForegroundColorAttributeName : HEXCOLOR(0xFF943C)};
    segmentedControl.selectionIndicatorHeight = 1;
    segmentedControl.selectionIndicatorColor = HEXCOLOR(0xFF943C);
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.segmentContent addSubview:segmentedControl];
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [self.tableview.mj_header beginRefreshing];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    [self searchAction];

    return YES;
}


-(void)searchAction{
    if (IS_STR_EMPTY(self.searchTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请先输入搜索编号"];
        return;
    }
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"orderNum"] = self.searchTextField.text;

    
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/posReceive/findPosReceveById.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:[OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            [self.tableview reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];

}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"矢量智能对象"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"什么都没有，请点击这里购买~";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, text.length)];
    // 设置指定4个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:HEXCOLOR(0x007EE5)
                   range:NSMakeRange(7, 4)];
    return attStr;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -70.0f;
}

#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
    WantMachineViewController * vc = [WantMachineViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.tableview.contentOffset = CGPointZero;
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
    QFBOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:orderTableViewCellIdentifier forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    OrderModel * model = self.dataArray[indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}


@end
