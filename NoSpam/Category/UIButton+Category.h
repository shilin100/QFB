//
//  UIButton+Category.h
//  QFB
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/**
 *  创建Button
 */
+ (UIButton *)createButton:(CGRect)cg targ:(id)targ sel:(SEL)sel titColor:(UIColor *)titleColor backGroundImage:(NSString *)backImage title:(NSString *)title;

@end
