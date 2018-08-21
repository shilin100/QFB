//
//  QFBAccountHeadView.m
//  QFB
//
//  Created by qqq on 2018/8/21.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAccountHeadView.h"

@implementation QFBAccountHeadView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(0xF5F3F3);
        
        UILabel * titleLabel = [UILabel new];
        titleLabel.font = XFont(12);
        titleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerY.equalTo(self);
            make.right.mas_equalTo(-20);
            make.left.mas_equalTo(20);
        }];

        
        
    }
    return self;
}
@end
