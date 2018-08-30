//
//  QFBDistributionCellModel.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBDistributionCellModel : NSObject

@property (nonatomic, strong) NSString *left;
@property (nonatomic, strong) NSString *right;

+ (instancetype)initWithLeft:(NSString *)ls right:(NSString *)rs;

@end
