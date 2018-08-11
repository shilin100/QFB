//
//  QFBEarningView.h
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBEarningTypeView.h"

@interface QFBEarningView : UIView

@property(nonatomic)PNPieChart * pieChart;
@property(nonatomic,strong)QFBEarningTypeView * earningTypeView;
@property(nonatomic,strong)UITableView * tableView;
@end
