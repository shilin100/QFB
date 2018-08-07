//
//  QFBBaseNaviViewController.m
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseNaviViewController.h"

@interface QFBBaseNaviViewController ()

@end

@implementation QFBBaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
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
