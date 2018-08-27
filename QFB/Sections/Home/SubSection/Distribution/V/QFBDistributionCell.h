//
//  QFBDistributionCell.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBDistributionCellModel.h"

@interface QFBDistributionCell : UITableViewCell

+ (instancetype)initWithTableView:(UITableView *)tv model:(QFBDistributionCellModel *)model;

@end
