//
//  QFBInvitingAnAllyController.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBInvitingAnAllyController.h"
#import "QFBInvitingBackView.h"
#import "QFBNavBarView.h"

@interface QFBInvitingAnAllyController ()

@property (nonatomic, strong) QFBInvitingBackView *view_back;
@property (nonatomic, strong) QFBNavBarView *view_bar;

@end

@implementation QFBInvitingAnAllyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.view_bar];
    [self.view addSubview:self.view_back];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_view_back updateImage:^(NSString *shareImageUrl) {
        //NSLog(@"shareImageUrl = %@"，shareImageUrl);
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (QFBNavBarView *)view_bar
{
    if (!_view_bar) {
        _view_bar = [QFBNavBarView initWithFrame:CGRectMake(0, 0, ScreenWidth, SafeAreaTopHeight)];
    }
    return _view_bar;
}

- (QFBInvitingBackView *)view_back
{
    if (!_view_back) {
        _view_back = [[QFBInvitingBackView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight)];
    }
    return _view_back;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end






