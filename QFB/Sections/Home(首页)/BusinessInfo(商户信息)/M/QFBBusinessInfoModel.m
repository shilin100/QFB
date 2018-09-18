//
//  QFBBusinessInfoModel.m
//  QFB
//
//  Created by qqq on 2018/9/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBusinessInfoModel.h"

@implementation QFBBusinessInfoModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBBusinessInfoModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end
