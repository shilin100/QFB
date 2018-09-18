//
//  QFBAllianceTeamTableViewCell.h
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBAllianceModel.h"

@interface QFBAllianceTeamTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

- (void)loadCellModel:(QFBAllianceModel *)model;

@end
