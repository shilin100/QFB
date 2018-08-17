//
//  QFBMyOrderViewController.m
//  QFB
//
//  Created by qqq on 2018/8/17.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMyOrderViewController.h"

@interface QFBMyOrderViewController ()
@property (strong, nonatomic)  NSMutableArray *dataArray;

@end

@implementation QFBMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    self.dataArray = [NSMutableArray array];
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
