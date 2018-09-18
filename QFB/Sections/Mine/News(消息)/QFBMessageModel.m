//
//  QFBMessageModel.m
//  QFB
//
//  Created by qqq on 2018/9/18.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMessageModel.h"

@implementation QFBMessageModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBMessageModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end



