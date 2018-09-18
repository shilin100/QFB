//
//  QFBBaseNavViewController.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseNetWorkController.h"
#import "NoDataView.h"

@interface QFBBaseNetWorkController ()

@property (nonatomic, strong) NoDataView * noDataView;

@end

@implementation QFBBaseNetWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.netWorkTool = [[QFBNetWorkTool alloc] init];
}



- (void)showNoDataViewWithTitle:(NSString *)title view:(UIView *)view
{
    if (_noDataView) {
        [_noDataView initWithTitle:title image:@"no_msg_icon"];
        return;
    }
    _noDataView = [NoDataView loadFromNib];
    [_noDataView initWithTitle:title image:@"no_msg_icon"];
    [_noDataView showNoDataViewOnView:view];
}


- (void)removeNoDataView
{
    if (_noDataView) {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}




@end
