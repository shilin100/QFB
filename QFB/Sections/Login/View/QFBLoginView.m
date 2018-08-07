//
//  QFBLoginView.m
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBLoginView.h"


@implementation QFBLoginView

-(instancetype)init{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor blueColor];
        
//        UIImageView *
        
        
        UILabel * title = [UILabel new];
        title.text = @"用户名";
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
        UIView * line = [UIView new];
        line.backgroundColor = HEXCOLOR(@"#CCCCCC");
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@8);
            make.right.mas_equalTo(@-8);
            make.top.mas_equalTo(@47);
            make.height.mas_equalTo(@1);
        }];

        
    }
    return self;
}

@end
