//
//  QFBDistributionController.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionController.h"
#import "QFBDistributionCell.h"
#import "QFBDistributionHeaderView.h"
#import "QFBDistributionFootView.h"

@interface QFBDistributionController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QFBDistributionHeaderView *headerView;
@property (nonatomic, strong) QFBDistributionFootView *footView;
@property (nonatomic, strong) NSMutableArray<QFBDistributionCellModel *> *arrayCellModels;

@end

@implementation QFBDistributionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"配送至";
    [self.view addSubview:self.tableView];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCellModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QFBDistributionCell initWithTableView:tableView model:self.arrayCellModels[indexPath.row]];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footView;
    }
    return _tableView;
}

- (QFBDistributionHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [QFBDistributionHeaderView initWithFrame:CGRectMake(0, 0, screen_width, 80) model:self.distributionModel.addressModel];
    }
    return _headerView;
}

- (QFBDistributionFootView *)footView
{
    if (!_footView) {
        _footView = [QFBDistributionFootView initWithFrame:CGRectMake(0, 0, screen_width, 100)];
    }
    return _footView;
}

- (NSMutableArray<QFBDistributionCellModel *> *)arrayCellModels
{
    if (!_arrayCellModels) {
        _arrayCellModels = [NSMutableArray array];
        QFBDistributionCellModel *model0 = [QFBDistributionCellModel initWithLeft:@"数量" right:[NSString stringWithFormat:@"%d",self.distributionModel.number]];
        QFBDistributionCellModel *model1 = [QFBDistributionCellModel initWithLeft:@"金额" right:[NSString stringWithFormat:@"%g",self.distributionModel.price]];
        QFBDistributionCellModel *model2 = [QFBDistributionCellModel initWithLeft:@"配送方式" right:@"普通快递"];
        QFBDistributionCellModel *model3 = [QFBDistributionCellModel initWithLeft:@"数量" right:@"7个工作日内安排发货"];
        [_arrayCellModels addObject:model0];
        [_arrayCellModels addObject:model1];
        [_arrayCellModels addObject:model2];
        [_arrayCellModels addObject:model3];
    }
    return _arrayCellModels;
}

@end







