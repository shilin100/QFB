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
@property (nonatomic, strong) NSString *imageUrl;

@end

@implementation QFBInvitingAnAllyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"邀请盟友";
    [self.view addSubview:self.view_back];
    // 安装了微信才创建
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pressShare)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    WEAKSELF;
    [_view_back updateImage:^(NSString *shareImageUrl) {
        weakSelf.imageUrl = shareImageUrl;
    }];
}

//  点击分享
- (void)pressShare
{
    NSString *title = [NSString stringWithFormat:@"%@邀您加入支付伙伴",[kDefault objectForKey:USERNAMEk]];//分享标题
    NSString *description = @"加入支付伙伴，玩转pos分销";//分享描述
    [ShareSDKTool createShareImageUrlStr:self.imageUrl urlStr:nil title:title text:description block:^(BOOL isSuccess) {
        
    }];
}

#pragma mark - 懒加载
- (QFBInvitingBackView *)view_back
{
    if (!_view_back) {
        _view_back = [[QFBInvitingBackView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.mj_w, self.view.mj_h - (SafeAreaBottomHeight - 49) - SafeAreaTopHeight)];
    }
    return _view_back;
}

- (void)dealloc
{
    logDealloc;
}

@end






