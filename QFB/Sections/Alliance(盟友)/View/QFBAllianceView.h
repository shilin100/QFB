//
//  QFBAllianceView.h
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBAllianceTableView.h"

@interface QFBAllianceView : UIView

@property(nonatomic,strong)QFBAllianceTableView * tableView;

/**
 获取累计盟友数、直接盟友、间接盟友
 */
-(void)getTransactionDict:(NSDictionary*)dict;

/**
 今日新增盟友数、今日新增直接盟友、今日新增间接盟友、团队激活商户数、今日新增盟友、累计激活商户
 */
-(void)getTodayAddFriendsDict:(NSDictionary*)dict;

/**
 本月直营商户交易额,//直营累计激活商户//团队累计激活商户
 */
- (void)getThisMonthMakeMoneyDict:(NSDictionary*)dict;

/**
 获取本月团队商户交易额
 */
- (void)getTheTeamMonthBusinessPriceDict:(NSString *)price;


-(void)setQFBAllianceTableViewModel:(id)viewModel;

@property (nonatomic, assign) NSInteger loadCount;

@end
