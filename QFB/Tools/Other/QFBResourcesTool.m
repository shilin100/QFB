//
//  QFBResourcesTool.m
//  QFB
//
//  Created by qqq on 2018/9/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBResourcesTool.h"

@implementation QFBResourcesTool

+ (UIImage *)tool_getNavigationBarBackImage
{
    if (iPhoneX) {
        return [UIImage imageNamed:@"mine_back_imag"];
    }else{
        return [UIImage imageNamed:@"navigationbar_image"];
    }
}

@end
