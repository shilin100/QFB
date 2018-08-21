//
//  QFBInvitingTitleView.h
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBInvitingTitleView : UIView

+ (instancetype)initWithFrame:(CGRect)frame leftText:(NSString *)leftStr right:(NSString *)rightStr;

- (void)changeTitle:(NSString *)title;
- (void)hiddenLine;

@end
