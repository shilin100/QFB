//
//  QFBDistributionFootView.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockPress)(BOOL isClick);

@interface QFBDistributionFootView : UIView

@property (nonatomic, strong) blockPress block;

+ (instancetype)initWithFrame:(CGRect)frame;


/**
 改变按钮字样显示

 @param money > 0 确认支付 反而 确认领取
 */
- (void)changeBtnTitleState:(double)money;


/**
 获取留言
 */
- (NSString *)getNote;

@end





