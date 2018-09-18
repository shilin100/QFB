//
//  AllianceModel.h
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllianceModel : NSObject

@end

@interface TransactionDetail : NSObject
@property(nonatomic,strong) NSString * id;
@property(nonatomic,strong) NSString * realName;
@property(nonatomic,strong) NSString * phone;
@property(nonatomic,strong) NSString * oBrandId;
@property(nonatomic,strong) NSString * psamId;
@property(nonatomic,strong) NSString * cleanTime;
@property(nonatomic,strong) NSString * psamCode;
@property(nonatomic,strong) NSString * price;
@property(nonatomic,strong) NSString * transactionTime;
@property(nonatomic,strong) NSString * transactionPrice;
@property(nonatomic,strong) NSString * transactionResult;
@property(nonatomic,strong) NSString * userId;
@property(nonatomic,strong) NSString * serviceName;
@property(nonatomic,strong) NSString * account;
@property(nonatomic,strong) NSString * remarks;
@property(nonatomic,strong) NSString * reserve;
@end
