//
//  QFBLoginViewController.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBLoginViewController.h"
#import "QFBLoginViewModel.h"
#import "QFBLoginView.h"
#import "QFBTabbarControllerConfig.h"

@interface QFBLoginViewController ()
@property(nonatomic,strong)QFBLoginView *containerView;
@property(nonatomic,strong)QFBLoginViewModel *viewModel;

@end

@implementation QFBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupUI];
    
    [self requsetBgImg];
    [self bind];
}

-(void)setupUI{
    QFBLoginView * containerView = [[QFBLoginView alloc]init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.containerView = containerView;
}

-(void)bind{
    @weakify(self)
    RAC(self.viewModel, userName) = self.containerView.userNameTextfield.rac_textSignal;
    RAC(self.viewModel, password) = self.containerView.passWordTextfield.rac_textSignal;
    
    
    self.containerView.loginBtn.rac_command = self.viewModel.loginCommand;
    
    [[self.viewModel.loginCommand executionSignals]
     subscribeNext:^(RACSignal *x) {
         
         [x subscribeNext:^(id x) {
             NSLog(@"登录成功返回的数据：%@",x);
//             @strongify(self);
             __block CYLTabBarController *  vc = [QFBTabbarControllerConfig initRootVCWithModules:[QFBTool getDefaultModules]];
             APPLication.keyWindow.rootViewController = vc;
         }];
     }];

    [self.containerView.userNameTextfield.rac_textSignal subscribeNext:^(NSString * x){
        
        static NSInteger const maxIntegerlength = 15;
        if (x.length) {
            if (x.length > 15) {
                @strongify(self);
                self.containerView.userNameTextfield.text = [self.containerView.userNameTextfield.text substringToIndex:maxIntegerlength];
            }
        }
    }];
    
    [self.containerView.passWordTextfield.rac_textSignal subscribeNext:^(NSString * x){
        
        static NSInteger const maxIntegerlength = 15;
        if (x.length) {
            if (x.length > 15) {
                @strongify(self);
                self.containerView.passWordTextfield.text = [self.containerView.passWordTextfield.text substringToIndex:maxIntegerlength];
            }
            
        }
    }];

}

-(void)requsetBgImg{
    [self.viewModel.getBgImgCommand execute:self.containerView.bgImgView];
}

-(QFBLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[QFBLoginViewModel alloc]init];
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
