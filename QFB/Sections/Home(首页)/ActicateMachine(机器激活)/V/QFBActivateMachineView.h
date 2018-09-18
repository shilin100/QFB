//
//  QFBActivateMachineView.h
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockClick)(int activateState);

@interface QFBActivateMachineView : UIView

@property (nonatomic, strong) blockClick block;     // 0：取消  1：成功    2：失败   3：验证码错误

+ (instancetype)initWithFrame:(CGRect)frame model:(QFBMachineActivateModel *)model;

@end
