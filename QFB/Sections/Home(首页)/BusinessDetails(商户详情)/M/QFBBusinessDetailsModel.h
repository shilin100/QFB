//
//  QFBBusinessDetailsModel.h
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"

@interface QFBBusinessDetailsModel : QFBBaseModel

//"id; // 25072,
@property (nonatomic, strong) NSString *phone;              // "暂无",
@property (nonatomic, strong) NSString *oBrandId;           // 5100,
@property (nonatomic, strong) NSString *psamId;             // 5176,
@property (nonatomic, strong) NSString *cleanTime;          // "挥卡(银行卡)",
@property (nonatomic, strong) NSString *psamCode;           // "00003102911804242871008",
@property (nonatomic, strong) NSString *transactionTime;    // "2018-08-02 13:38",
@property (nonatomic, strong) NSString *transactionPrice;   // "0.01",
@property (nonatomic, strong) NSString *transactionResult;  // "海科",
@property (nonatomic, strong) NSString *userId;             // 10189,
@property (nonatomic, strong) NSString *serviceName;        // 25,
@property (nonatomic, strong) NSString *account;            // "6212*****6001",
@property (nonatomic, strong) NSString *remarks;            // "27"

@end
