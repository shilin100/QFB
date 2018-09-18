//
//  UIButton+Category.m
//  QFB
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

+ (UIButton *)createButton:(CGRect)cg targ:(id)targ sel:(SEL)sel titColor:(UIColor *)titleColor backGroundImage:(NSString *)backImage title:(NSString *)title
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg;
//    CGFloat w = cg.size.width;
//    CGFloat h = cg.size.height;
    bt.titleLabel.font = [UIFont systemFontOfSize:11];
    bt.titleLabel.textAlignment = 1;
    bt.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [bt setImageEdgeInsets:UIEdgeInsetsMake(5, 5, h - w + 5, 5)];
//    [bt setTitleEdgeInsets:UIEdgeInsetsMake(w, -w, 0, 0)];
    if(title){
        [bt setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [bt setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (backImage) {
        [bt setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    }
    if (targ) {
        [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return bt;
}

@end
