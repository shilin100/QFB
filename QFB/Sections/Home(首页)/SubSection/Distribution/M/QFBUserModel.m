//
//  QFBUserModel.m
//  QFB
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBUserModel.h"

@implementation QFBUserModel

MJCodingImplementation

- (instancetype)init
{
    if (self = [super init]) {
        [QFBUserModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end


@implementation QFBRoleModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBRoleModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id"
                     };
        }];
    }
    return self;
}

@end
