//
//  QFBListButton.m
//  QFB
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBListButton.h"

@implementation QFBListButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(0, titleW - 5 , titleW, contentRect.size.height - titleW);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = CGRectGetWidth(contentRect) - 30;
    return CGRectMake(15, 20, imageW, imageW);
}

@end
