//
//  QFBDistributionModel.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFBAddressModel.h"

@interface QFBDistributionModel : NSObject

@property (nonatomic, strong) QFBAddressModel *addressModel;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *addressType;
@property (nonatomic, strong) NSString *addressTime;

@end
