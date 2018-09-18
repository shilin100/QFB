//
//  QFBBusinessDetailsController.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBusinessDetailsController.h"
#import "QFBBusinessDetailsCell.h"

@interface QFBBusinessDetailsController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *image_user;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_money;
@property (weak, nonatomic) IBOutlet UILabel *label_code;
@property (weak, nonatomic) IBOutlet UILabel *label_nowMonthTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_nowMonth;
@property (weak, nonatomic) IBOutlet UILabel *label_lastMonthTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_lastMonth;
@property (weak, nonatomic) IBOutlet UILabel *label_earliestMonthTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_earliestMonth;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray<QFBBusinessDetailsModel *> *dataArray;
@property (nonatomic, strong) NSString *myPhone;

@end

@implementation QFBBusinessDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商户详情";
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self loadBusinessDetailsModel];
}

- (void)loadBusinessDetailsModel
{
    WEAKSELF;
    [self.netWorkTool net_getShopMessageDetailWithPasmCode:self.myPsamCode blockRequest:^(NSDictionary *dic, RequestState state) {
        if (state == net_succes) {
            weakSelf.myPhone = dic[@"reserve"];
            weakSelf.label_code.text = dic[@"psamCode"];
            weakSelf.label_time.text = dic[@"activeTime"];
            if (LMJIsEmpty(dic[@"remarks"])) {
                weakSelf.label_name.text = @"未实名";
            }else{
                weakSelf.label_name.text = dic[@"remarks"];
            }
        }
    }];
    [self.netWorkTool net_getShopMessageTradeListWithPasmCode:self.myPsamCode blockRequest:^(NSDictionary *dic, RequestState state) {
        if (state == net_succes) {
            weakSelf.dataArray = [NSMutableArray arrayWithArray:[QFBBusinessDetailsModel mj_objectArrayWithKeyValuesArray:dic[@"transactions"]]];
            int maxMonth = [DCSpeedy getCurrentMonthTime];
            weakSelf.label_nowMonthTitle.text = [NSString stringWithFormat:@"%d月交易额",maxMonth];
            weakSelf.label_lastMonthTitle.text = [NSString stringWithFormat:@"%d月交易额",(maxMonth + 10) % 12 + 1];
            weakSelf.label_earliestMonthTitle.text = [NSString stringWithFormat:@"%d月交易额",(maxMonth + 9) % 12 + 1];
            weakSelf.label_nowMonth.text = [NSString stringWithFormat:@"%@",dic[@"countPriceNow"]];       // 10
            weakSelf.label_lastMonth.text = [NSString stringWithFormat:@"%@",dic[@"countPriceBefore"]];   // 9
            weakSelf.label_earliestMonth.text = [NSString stringWithFormat:@"%@",dic[@"countPriceLast"]]; // 8
            [weakSelf.myTableView reloadData];
        }
    }];
}

- (IBAction)pressPhone:(id)sender {
    if (LMJIsEmpty(_myPhone)) {
        [SVProgressHUD showInfoWithStatus:@"没有该商户电话"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    NSString *str=[[NSString alloc] initWithFormat:@"tel:%@",_myPhone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QFBBusinessDetailsCell initWithTableView:tableView model:self.dataArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end












