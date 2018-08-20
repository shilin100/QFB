//
//  QFBOrderTableViewCell.h
//  QFB
//
//  Created by qqq on 2018/8/17.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface QFBOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *flowState;
@property (weak, nonatomic) IBOutlet UILabel *flowCompany;
@property (weak, nonatomic) IBOutlet UILabel *flowNum;


-(void)setCellWithModel:(OrderModel*)model;
@end
