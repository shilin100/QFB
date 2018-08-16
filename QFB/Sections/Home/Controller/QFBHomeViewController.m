//
//  QFBHomeViewController.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeViewController.h"
#import "QFBHomeView.h"
#import "QFBHomeViewModel.h"

@interface QFBHomeViewController ()

@property(nonatomic,strong)QFBHomeView *containerView;
@property(nonatomic,strong)QFBHomeViewModel *viewModel;

@end

@implementation QFBHomeViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self bind];
    
}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    QFBHomeView * containerView = [[QFBHomeView alloc]init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.containerView = containerView;
    //[containerView setTableViewModel:self.viewModel];
    
    
}
-(void)bind{
    
    [self.viewModel.getDataCommand execute:self.containerView];
}
-(QFBHomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[QFBHomeViewModel alloc]init];
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
