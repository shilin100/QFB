//
//  QFBEarningView.h
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBEarningTypeView.h"

@class QFBEarningTableView;
@class QFBEarningLevelView;

@interface QFBEarningView : UIView

@property(nonatomic)PNPieChart * pieChart;
@property(nonatomic,strong)QFBEarningTypeView * earningTypeView;
@property(nonatomic,strong)QFBEarningTableView * tableView;
@property(nonatomic,strong)QFBEarningLevelView * levelView;

@property(nonatomic,strong)UIButton *extendBtn;
@property(nonatomic,strong)UIButton *inviteBtn;
@property(nonatomic,strong)UIButton *buyDeviceBtn;

@property(nonatomic,strong)NSString *beyondPartnerStr;
@property(nonatomic,strong)NSString *totalEarningCountStr;

@property(nonatomic,strong)UIScrollView *scrollview;


-(void)creatChartWith:(float)personal :(float)team :(float)brand;
-(void)setTableViewModel:(id)viewModel;
-(void)changeLevel:(NSString *)level;
@end

