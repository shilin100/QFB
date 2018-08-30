//
//  QFBDistributionCellModel.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionCellModel.h"

@implementation QFBDistributionCellModel

+ (instancetype)initWithLeft:(NSString *)ls right:(NSString *)rs
{
    QFBDistributionCellModel *model = [[QFBDistributionCellModel alloc] init];
    model.left = ls;
    model.right = rs;
    return model;
}

@end
