//
//  OrderModel.h
//  QFB
//
//  Created by qqq on 2018/8/17.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * typeNumTwo;
@property (nonatomic , assign) NSInteger              orderTime;
@property (nonatomic , copy) NSString              * typeNumThree;
@property (nonatomic , copy) NSString              * note;
@property (nonatomic , copy) NSString              * remarksOne;
@property (nonatomic , copy) NSString              * remarksTwo;
@property (nonatomic , copy) NSString              * remarksThree;
@property (nonatomic , copy) NSString              * typeNumFive;
@property (nonatomic , copy) NSString              * remarksFour;
@property (nonatomic , copy) NSString              * typeNumFour;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * ext;
@property (nonatomic , copy) NSString              * adress;
@property (nonatomic , copy) NSString              * orderNumber;
@property (nonatomic , copy) NSString              * typeNum;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * sendNum;

@end
