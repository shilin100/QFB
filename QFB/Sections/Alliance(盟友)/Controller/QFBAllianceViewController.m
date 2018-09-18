//
//  QFBAllianceViewController.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceViewController.h"
#import "QFBAllianceView.h"
#import "QFBAllianceViewModel.h"
#import "QFBTeamEarnViewController.h"
#import "TransactionDetailViewControllerr.h"

@interface QFBAllianceViewController ()

@property(nonatomic,strong)QFBAllianceView *containerView;
@property(nonatomic,strong)QFBAllianceViewModel *viewModel;

@end

@implementation QFBAllianceViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self bind];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[QFBResourcesTool tool_getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

-(void)setupUI{
//    self.title = @"盟友";
    self.view.backgroundColor = [UIColor whiteColor];

    QFBAllianceView * containerView = [[QFBAllianceView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:containerView];
    self.containerView = containerView;
    [containerView setQFBAllianceTableViewModel:self.viewModel];
    AdjustsScrollViewInsetNever(self, containerView.tableView)
    
    [self.viewModel.earningCellCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSString * temp  = x ;
        if ([temp isEqualToString:@"团队"]) {
            QFBTeamEarnViewController * vc = [QFBTeamEarnViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([temp isEqualToString:@"直营"]) {
            TransactionDetailViewControllerr * vc = [TransactionDetailViewControllerr new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
}

-(void)bind{
    self.containerView.loadCount = 0;
    [self.viewModel.getDataCommand execute:self.containerView];
}

-(QFBAllianceViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[QFBAllianceViewModel alloc]init];
    }
    return _viewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end






