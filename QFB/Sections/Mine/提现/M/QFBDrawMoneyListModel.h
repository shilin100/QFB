//
//  QFBDrawMoneyListModel.h
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBDrawMoneyListModel : NSObject

@property (nonatomic, strong) NSString *blackAccountName;   // 姓名,
@property (nonatomic, strong) NSString *blackNum;           // "brtomo@163.com",
@property (nonatomic, strong) NSString *rate;               // 比率    "(null)"


@property (nonatomic, assign) double    active;             // 激活返现 "65.00",
@property (nonatomic, assign) double    allActive;          // 所有的激活 "435",
@property (nonatomic, assign) int       activeTime;         // 激活时间 <null>,
@property (nonatomic, assign) int       activeStatus;       // 激活状态 0,

@property (nonatomic, assign) double    recommend;          // 代理返现 "1600",
@property (nonatomic, assign) double    allRecommend;       // 所有"1600",
@property (nonatomic, assign) int       recommendTime;      // 返现时间, 0 妙提
@property (nonatomic, assign) int       recommendStatus;    // 返现状态 0妙结 1月结

@property (nonatomic, assign) double    profit;             // 分润返现   "0.000",
@property (nonatomic, assign) double    allProfit;          // 所有利润 "0",
@property (nonatomic, assign) int       profitTime;         // 利润时间 "15",
@property (nonatomic, assign) int       profitStatus;       // 1,

@end
