//
//  FriendContactViewController.m
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "FriendContactViewController.h"
#import "NoDataView.h"

@interface FriendContactViewController ()

@property (nonatomic, strong) NoDataView * noDataView;

@end

@implementation FriendContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"盟友通讯";
    [self getRecommendMan];
}
#pragma mark - service
- (void)getRecommendMan{
     [self showNoDataViewWithTitle:@"亲，您还没有相关盟友，快去邀请好友吧！" image:@"no_msg_icon"];
    
}
- (void)showNoDataViewWithTitle:(NSString *)title image:(NSString *)image
{
    if (_noDataView) {
        [_noDataView initWithTitle:title image:image];
        return;
    }
    _noDataView = [NoDataView loadFromNib];
    [_noDataView initWithTitle:title image:image];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 58)];
    _tableView.tableFooterView = tableFooterView;
    [_noDataView showNoDataViewOnView:tableFooterView];
}

- (void)removeNoDataView
{
    if (_noDataView) {
        _tableView.tableHeaderView  = [UIView new];
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
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
