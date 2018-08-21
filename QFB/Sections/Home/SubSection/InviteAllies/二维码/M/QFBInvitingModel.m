//
//  QFBInvitingModel.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBInvitingModel.h"

@implementation QFBInvitingListModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBInvitingListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id",
                     };
        }];
    }
    return self;
}

@end

@implementation QFBInvitingModel

- (instancetype)init
{
    if (self = [super init]) {
        [QFBInvitingModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id",
                     };
        }];
        [QFBInvitingModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"QFBInvitingListModel",
                     };
        }];
    }
    return self;
}


@end
