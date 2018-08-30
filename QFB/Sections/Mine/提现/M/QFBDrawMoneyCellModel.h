//
//  QFBDrawMoneyCellModel.h
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBDrawMoneyCellModel : NSObject

@property (nonatomic, strong) NSString *returnMode;     // 返现模式
@property (nonatomic, assign) int setMode;              // 结算方式 0:妙结 1月结
@property (nonatomic, assign) double allMoney;          // 总金额
@property (nonatomic, assign) double frozenMoney;       // 冻结金额
@property (nonatomic, assign) double useMoney;          // 可使用金额

@end
