//
//  QFBBrandEarnViewController.m
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBrandEarnViewController.h"
#import "TeamTradeTableViewCell.h"
#import "QFBBrandEarnModel.h"

@interface QFBBrandEarnViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *EarnLabel;
@property (strong, nonatomic)  HMSegmentedControl *segmentView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (strong, nonatomic)  NSMutableArray *brandArray;

@end

@implementation QFBBrandEarnViewController

static NSString * BrandTradeTableViewCellIdentifier = @"BrandTradeTableViewCellIdentifier";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"品牌收益";
    self.dataArray = [NSMutableArray array];
    self.brandArray = [NSMutableArray array];
    [self.tableview registerNib:[UINib nibWithNibName:@"TeamTradeTableViewCell" bundle:nil] forCellReuseIdentifier:BrandTradeTableViewCellIdentifier];
    self.headView.frame = CGRectMake(0, 0, ScreenWidth, 195 + (SafeAreaTopHeight - 64));
    [self.view addSubview:self.headView];
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.headView.frame) - (SafeAreaBottomHeight - 49));
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    [self requestBrandList];
    AdjustsScrollViewInsetNever(self, self.tableview);
}

-(void)requestBrandList{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"oBrandId"] = O_BRAND_ID;

    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/posbrand/selectByobrandId.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            NSArray * arr = responseObject[@"data"];
            for (NSDictionary * dic in arr) {
                [self.brandArray addObject:dic[@"posName"]];
            }

            [self creatSegment];
            [self.tableview.mj_header beginRefreshing];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
    } andFaild:^(NSError *error) {

    }];
    
}


-(void)requestData{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"posName"] = self.segmentView.sectionTitles[self.segmentView.selectedSegmentIndex];

    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/billDetailController/selectBrandReturns.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [self.dataArray removeAllObjects];
            NSMutableArray *modelArr = [QFBBrandEarnModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"details"]];
            for (int i = 0; i < modelArr.count; i++) {
                QFBBrandEarnModel *model = modelArr[i];
                if ([model.price doubleValue] > 0) {
                    [self.dataArray addObject:model];
                }
            }
            [self.tableview reloadData];
            self.EarnLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"sumprice"]];

        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        [self.tableview.mj_header endRefreshing];
    } andFaild:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
    
}

-(void)creatSegment{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.brandArray];
    segmentedControl.frame = CGRectMake(0, 135 + (SafeAreaTopHeight - 64), kSCREEN_WIDTH, 35);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    //    segmentedControl.verticalDividerEnabled = YES;
    //    segmentedControl.verticalDividerColor = RGBCOLOR(235, 235, 235);
    //    segmentedControl.verticalDividerWidth = 1.0f;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName : XFont(14),NSForegroundColorAttributeName : [UIColor blackColor]};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName : XFont(16),NSForegroundColorAttributeName : HEXCOLOR(0xFF943C)};
    segmentedControl.selectionIndicatorHeight = 0;
//    segmentedControl.selectionIndicatorColor = HEXCOLOR(0xFF943C);
//    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.headView addSubview:segmentedControl];

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {

    [self.tableview.mj_header beginRefreshing];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeamTradeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BrandTradeTableViewCellIdentifier forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    QFBBrandEarnModel * model = self.dataArray[indexPath.row];
    [cell setBrandCellWithModel:model];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}


@end













