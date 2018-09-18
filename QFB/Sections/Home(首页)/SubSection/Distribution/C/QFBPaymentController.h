//
//  QFBPaymentController.h
//  QFB
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBPaymentController : UIViewController

@property (nonatomic, assign) double amountOfPayment;   // 需要付款金额
@property (nonatomic, assign) int payType; // 0:买机器 1:购买会员
@property (nonatomic, strong) NSString *roleID; // 角色ID

@end
