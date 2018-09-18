//
//  QFBMachineTransUsersController.h
//  QFB
//
//  Created by qqq on 2018/9/12.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseNetWorkController.h"

typedef void(^blockUserModel)(QFBUserModel *model);

@interface QFBMachineTransUsersController : QFBBaseNetWorkController

@property (nonatomic, strong) blockUserModel block;

@end
