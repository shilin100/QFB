//
//  QFBDistributionHeaderView.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBAddressModel.h"

@interface QFBDistributionHeaderView : UIView

+ (instancetype)initWithFrame:(CGRect)frame model:(QFBAddressModel *)addressModel;

- (void)loadAddressModel:(QFBAddressModel *)model;

- (QFBAddressModel *)getSelelctorAddress;

@end
