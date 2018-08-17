//
//  QFBHomeView.h
//  QFB
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "QFBHomeFunctionButtonView.h"
#import "QFBHomeTableView.h"
#import "QFBHomeModel.h"


@interface QFBHomeView : UIView


@property(nonatomic,strong)NSArray * rootingArray;

//轮播图
- (void)MenuAndRooting:(NSArray*)rootingArray MenuArray:(NSArray*)MenuArray;
//余额
-(void)getBalanceStr:(NSString *)BalanceStr;
//收益
-(void)getEarningsStr:(NSString *)EarningsStr;
//盟友
-(void)getAddFriendStr:(NSString *)AddFriendStr MyRankingStr:(NSString *)MyRankingStr AddUserStr:(NSString *)AddUserStr;

-(void)setQFBHomeFunctionButtonViewModel:(id)viewModel;
@end
