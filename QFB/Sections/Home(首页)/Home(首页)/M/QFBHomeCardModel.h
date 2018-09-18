//
//  QFBHomeCardModel.h
//  QFB
//
//  Created by qqq on 2018/9/8.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"

@interface QFBHomeCardModel : QFBBaseModel

@property (nonatomic, strong) NSArray *newsList; // [
//                          "您有一条98元的激活收益通知！！！",
//                          "您有一条470.00元的支付宝提现通知！！！",
//                          "您有一条10元的激活收益通知！！！",
//                          "您有一条5元的激活收益通知！！！",
//                          "您有一条10元的激活收益通知！！！"
//                          ],
@property (nonatomic, strong) NSString *price; // "5180",
@property (nonatomic, strong) NSString *friendNum; // 797,    // 新增盟友
@property (nonatomic, strong) NSString *activeNum; // 1       // 激活用户

@end
