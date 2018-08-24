//
//  QFBDrawMoneyBottomView.h
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockPressBtn)(BOOL);

@interface QFBDrawMoneyBottomView : UIView

@property (nonatomic, strong) blockPressBtn pressSure;

+ (instancetype)initWithFrame:(CGRect)frame;

// 设置名字 支付宝账号
- (void)loadName:(NSString *)name number:(NSString *)num rate:(NSString *)rate;

- (double)getMoney;   //  获取用户需要提的金额

@end
