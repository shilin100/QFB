//
//  QFBHomeModel.m
//  QFB
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeModel.h"

@implementation RootingModel

@end


@implementation MenuModel

@end

@implementation BuyMachine
-(instancetype)init
{
    if (self = [super init]) {
        [BuyMachine mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id",
                     };
        }];
    }
    return self;
}
@end


@implementation PosMachine

@end


@implementation FriendUpgrade

@end

