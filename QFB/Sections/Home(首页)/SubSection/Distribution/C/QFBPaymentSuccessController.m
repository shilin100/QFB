//
//  QFBPaymentSuccessController.m
//  QFB
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBPaymentSuccessController.h"

@interface QFBPaymentSuccessController ()

@property (weak, nonatomic) IBOutlet UILabel *label_tips;
@property (weak, nonatomic) IBOutlet UILabel *label_title;

@end

@implementation QFBPaymentSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isPay) {
        self.label_title.text = @"购买成功";
        self.label_tips.text = @"恭喜您 购买成功";
    }else{
        self.label_title.text = @"领取成功";
        self.label_tips.text = @"恭喜您 领取成功";
    }
}

- (IBAction)pressBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end





