//
//  QFBBrandEarnModel.h
//  QFB
//
//  Created by qqq on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBBrandEarnModel : NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * serviceCharge;
@property (nonatomic , copy) NSString              * oBrandId;
@property (nonatomic , copy) NSString              * billDate;
@property (nonatomic , copy) NSString              * psamId;
@property (nonatomic , copy) NSString              * billType;
@property (nonatomic , copy) NSString              * userId;
@property (nonatomic , copy) NSString              * billDetail;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * taxRate;
@property (nonatomic , copy) NSString              * posTypeId;
@property (nonatomic , copy) NSString              * lowerId;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * reserve;

@end
