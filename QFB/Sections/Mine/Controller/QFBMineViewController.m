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
#import "QFBAddressViewController.h"
#import "QFBMyProtocolViewController.h"
#import "QFBAccountViewController.h"

@interface QFBMineViewController ()
@property(nonatomic,strong)QFBMineView *containerView;
@property(nonatomic,strong)QFBMineViewModel *viewModel;

@property (nonatomic,copy) NSString *trackViewUrl1;
@property (nonatomic, copy)  NSString  *localVersion;
@property (nonatomic,copy) NSString *releaseNotesStr;
@property (nonatomic,copy) NSString *servicePhone;


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
    [containerView setTableViewModel:self.viewModel];
}

-(void)bind{
    //    @weakify(self)
    
    self.containerView.accountBtn.rac_command = self.viewModel.accountCommand;
    [[self.viewModel.accountCommand executionSignals]
     subscribeNext:^(RACSignal *x) {
         
         [x subscribeNext:^(id x) {
             QFBAccountViewController * vc = [QFBAccountViewController new];
             [self.navigationController pushViewController:vc animated:YES];

         }];
     }];

    
    [self.viewModel.getDataCommand execute:self.containerView];
    
    [self.viewModel.mineCellCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSString * temp  = x ;
        if ([temp isEqualToString:@"我的收货地址"]) {
            
            QFBAddressViewController * vc = [QFBAddressViewController new];
            [self.navigationController pushViewController:vc animated:YES];

        }
        if ([temp isEqualToString:@"我的订单"]) {
            QFBMyOrderViewController * vc = [QFBMyOrderViewController new];
            [self.navigationController pushViewController:vc animated:YES];

        }
        if ([temp isEqualToString:@"代理协议"]) {
            QFBMyProtocolViewController * vc = [QFBMyProtocolViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([temp isEqualToString:@"版本检测"]) {
            [self checkVersion];
        }
        if ([temp isEqualToString:@"我的专属客服"]) {
            if (IS_STR_EMPTY(self.servicePhone)) {
                [SVProgressHUD showErrorWithStatus:@"客服电话获取失败，请稍后再试"];
                return;
            }
            UIWebView * callWebview = [[UIWebView alloc]init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.servicePhone]]]];
            [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
        }
    }];
    
    [[self.viewModel.myServiceCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        NSDictionary * dic = x;
        self.servicePhone = dic[@"data"][@"oBrandPhone"];
        
    }];

    
}

-(void)checkVersion{
    //请求参数
    NSString *urlStr = [NSString stringWithFormat:@"%@id=%@",APP_checkUp,APPID];
    [QFBNetTool GetRequestWithUrlString:urlStr Succeed:^(NSDictionary *responseObject) {
        NSDictionary *dic=responseObject;
        NSArray *array=dic[@"results"];
        NSDictionary *dict = [array lastObject];
        self->_releaseNotesStr = dict[@"releaseNotes"];
        NSLog(@"%@",responseObject);
        if (array.count>0) {
            NSDictionary *releaseInfo = [array objectAtIndex:0];
            NSString *latestVersion = [releaseInfo objectForKey:@"version"];
            self->_trackViewUrl1 = [releaseInfo objectForKey:@"trackViewUrl"];//地址trackViewUrl
            //            NSString *trackName = [releaseInfo objectForKey:@"trackName"];
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            //获取本地版本号
            self->_localVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            //            NSLog(@"currentVersion %@ CFBundleShortVersionString %@   %@",latestVersion ,_localVersion ,infoDict);
            if ([latestVersion compare:self->_localVersion]==NSOrderedDescending) {
                [self alertUpdateControl:@"有新版本可供更新"];
            }else{
                [SVProgressHUD showInfoWithStatus:@"已是最新版本"];
            }
        }
        
    } andFaild:^(NSError *error) {
        
    }];
    
}

-(void)alertUpdateControl:(NSString*)title
{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:_releaseNotesStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",APPID]]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertControl addAction:action];
    [alertControl addAction:cancelAction];
    [self presentViewController:alertControl animated:YES completion:nil];
    
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
