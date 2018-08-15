//
//  TeamTradeTableViewCell.h
//  ZFLM
//
//  Created by BoFeng on 2018/5/22.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFBTeamEarnModel;
@class QFBBrandEarnModel;

@interface TeamTradeTableViewCell : UITableViewCell
-(void)setEarnCellWithModel:(QFBTeamEarnModel*)model;
-(void)setBrandCellWithModel:(QFBBrandEarnModel*)model;



@end
