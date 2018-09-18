//
//  QFBHomeHeaderView.m
//  QFB
//
//  Created by qqq on 2018/9/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeHeaderView.h"


@interface QFBHomeHeaderView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation QFBHomeHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.label setTextColor:[UIColor colorWithRed:102 / 255.0 green:171 / 255.0 blue:225 / 255.0 alpha:1]];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)setTitleText:(NSString *)str
{
    if (str) {
        self.label.hidden = NO;
        self.label.text = str;
    }else{
        self.label.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(15, 5, self.mj_w - 30, self.mj_h - 5);
}

@end
