//
//  QFBTeamEarnModel.h
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBTeamEarnModel : NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * oBrandId;
@property (nonatomic , copy) NSString              * psamId;
@property (nonatomic , copy) NSString              * cleanTime;
@property (nonatomic , copy) NSString              * psamCode;
@property (nonatomic , assign) CGFloat               price;
@property (nonatomic , copy) NSString              * transactionTime;
@property (nonatomic , copy) NSString              * transactionPrice;
@property (nonatomic , copy) NSString              * transactionResult;
@property (nonatomic , copy) NSString              * userId;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * serviceName;
@property (nonatomic , copy) NSString              * account;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * reserve;

@end
