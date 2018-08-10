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
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    QFBEarningView * containerView = [[QFBEarningView alloc]init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.containerView = containerView;
}


-(QFBEarningViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[QFBEarningViewModel alloc]init];
    }
    return _viewModel;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
