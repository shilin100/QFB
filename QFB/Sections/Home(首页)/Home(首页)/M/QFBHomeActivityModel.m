//
//  QFBHomeActivityModel.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeActivityModel.h"

@implementation QFBHomeActivityModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBHomeActivityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end
