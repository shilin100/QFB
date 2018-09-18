//
//  QFBHomeListModel.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeListModel.h"

@implementation QFBHomeListModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBHomeListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end
