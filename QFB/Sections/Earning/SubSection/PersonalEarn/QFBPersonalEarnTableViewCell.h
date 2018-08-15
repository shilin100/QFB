//
//  QFBPersonalEarnTableViewCell.h
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QFBPersonalEarnModel;

@interface QFBPersonalEarnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *recommandLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenrunLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;


- (void)setCellWithModel:(QFBPersonalEarnModel *)model;


@end
