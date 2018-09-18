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
#import "MachineActivateViewController.h"
#import "InviteAlliesViewController.h"
#import "WantMachineViewController.h"

#import "QFBActivateMachineController.h"
#import "QFBInvitingAnAllyController.h"


@interface QFBEarningViewController ()
@property(nonatomic,strong)QFBEarningView *containerView;
@property(nonatomic,strong)QFBEarningViewModel *viewModel;

@end

@implementation QFBEarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收益";
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self bind];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[QFBResourcesTool tool_getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)clickRuleBtn{
    QFBUpgradeRuleViewController * vc = [QFBUpgradeRuleViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    QFBEarningView * containerView = [[QFBEarningView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - SafeAreaBottomHeight)];
    [self.view addSubview:containerView];
    self.containerView = containerView;
    [containerView setTableViewModel:self.viewModel];
    AdjustsScrollViewInsetNever(self, containerView.tableView);
    
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
    [[self.containerView.extendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        QFBActivateMachineController * vc = [[QFBActivateMachineController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.containerView.inviteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        QFBInvitingAnAllyController * vc = [[QFBInvitingAnAllyController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.containerView.buyDeviceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        WantMachineViewController * vc = [WantMachineViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

-(void)bind
{
    [self.viewModel.getDataCommand execute:self.containerView];
}

-(QFBEarningViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[QFBEarningViewModel alloc]init];
    }
    return _viewModel;
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
