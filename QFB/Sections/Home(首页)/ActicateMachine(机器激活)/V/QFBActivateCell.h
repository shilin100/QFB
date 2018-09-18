//
//  QFBActivateCell.h
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivateCellDelegate<NSObject>

- (void)machineModel:(QFBMachineModel *)model type:(int)type;

@end

@interface QFBActivateCell : UITableViewCell

@property (nonatomic, weak) id <ActivateCellDelegate> delegate;

+ (instancetype)initWithTableView:(UITableView *)tableView model:(QFBMachineModel *)model;

@end
