//
//  QFBMachineModel.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMachineModel.h"

@implementation QFBMachineModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBMachineModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end



@implementation QFBMachineActivateModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBMachineActivateModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end
