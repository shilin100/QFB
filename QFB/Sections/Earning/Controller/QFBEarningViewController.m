//
//  QFBEarningViewController.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningViewController.h"
#import "QFBEarningView.h"
#import "QFBEarningViewModel.h"
#import "QFBUpgradeRuleViewController.h"
#import "QFBTeamEarnViewController.h"
#import "QFBBrandEarnViewController.h"
#import "QFBPersonalEarnViewController.h"

@interface QFBEarningViewController ()
@property(nonatomic,strong)QFBEarningView *containerView;
@property(nonatomic,strong)QFBEarningViewModel *viewModel;

@end

@implementation QFBEarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收益";
    
//    UIBarButtonItem * doneButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"升级规则" style:UIBarButtonItemStyleDone target:self action:@selector(clickRuleBtn)];
//    self.navigationItem.rightBarButtonItem = doneButtonItem;

    [self setupUI];

    [self bind];
}

-(void)clickRuleBtn{
    
    QFBUpgradeRuleViewController * vc = [QFBUpgradeRuleViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    QFBEarningView * containerView = [[QFBEarningView alloc]init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.containerView = containerView;
    [containerView setTableViewModel:self.viewModel];
    AdjustsScrollViewInsetNever(self, containerView.scrollview)

}

-(void)bind{
//    @weakify(self)
    
    [self.viewModel.getDataCommand execute:self.containerView];
    
    [self.viewModel.earningCellCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSString * temp  = x ;
        if ([temp isEqualToString:@"个人收益"]) {
            QFBPersonalEarnViewController * vc = [QFBPersonalEarnViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([temp isEqualToString:@"团队收益"]) {
            QFBTeamEarnViewController * vc = [QFBTeamEarnViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([temp isEqualToString:@"品牌收益"]) {
            QFBBrandEarnViewController * vc = [QFBBrandEarnViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }];

}

-(QFBEarningViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[QFBEarningViewModel alloc]init];
    }
    return _viewModel;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
