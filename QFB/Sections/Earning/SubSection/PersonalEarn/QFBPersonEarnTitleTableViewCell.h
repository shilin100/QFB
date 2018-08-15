//
//  QFBPersonEarnTitleTableViewCell.h
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFBPersonalEarnModel;

@interface QFBPersonEarnTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
- (void)setCellWithModel:(QFBPersonalEarnModel *)model;
@end
