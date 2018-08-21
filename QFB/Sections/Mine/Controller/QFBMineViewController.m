//
//  QFBMineViewController.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMineViewController.h"
#import "QFBMineView.h"
#import "QFBMineViewModel.h"
#import "QFBMyOrderViewController.h"

@interface QFBMineViewController ()
@property(nonatomic,strong)QFBMineView *containerView;
@property(nonatomic,strong)QFBMineViewModel *viewModel;

@end

@implementation QFBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    [self setupUI];
    [self bind];

}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    QFBMineView * containerView = [[QFBMineView alloc]init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.containerView = containerView;
//    [containerView setTableViewModel:self.viewModel];
}

-(void)bind{
    //    @weakify(self)
    
    [self.viewModel.getDataCommand execute:self.containerView];
    
    [self.viewModel.mineCellCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSString * temp  = x ;
        if ([temp isEqualToString:@"个人收益"]) {

        }
        if ([temp isEqualToString:@"我的订单"]) {
            QFBMyOrderViewController * vc = [QFBMyOrderViewController new];
            [self.navigationController pushViewController:vc animated:YES];

        }
        if ([temp isEqualToString:@"品牌收益"]) {
            QFBMineViewController * vc = [QFBMineViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_image"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


-(QFBMineViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [QFBMineViewModel new];
    }
    return _viewModel;
}
@end
