//
//  QFBAddressModel.h
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBAddressModel : NSObject
@property (nonatomic , assign) NSInteger             userId;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , assign) NSInteger             defaultAddress;
@property (nonatomic , assign) NSInteger             isremove;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * reserveOne;
@property (nonatomic , copy) NSString              * reserve;
@property (nonatomic , copy) NSString              * sex;
@property (nonatomic , copy) NSString              * name;

@end
