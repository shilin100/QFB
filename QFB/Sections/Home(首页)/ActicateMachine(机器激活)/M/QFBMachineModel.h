//
//  QFBMachineModel.h
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"

@interface QFBMachineModel : QFBBaseModel
@property(nonatomic,strong) NSString *activeStatus;
@property(nonatomic,strong) NSString *posBrandId;
@property(nonatomic,strong) NSString *remarks;
@property(nonatomic,strong) NSString *ID;
@property(nonatomic,strong) NSString *activeTime;
@property(nonatomic,strong) NSString *reserve;
@property(nonatomic,strong) NSString *psamCode;
@end

@interface QFBMachineActivateModel : QFBBaseModel
@property(nonatomic,strong) NSString *checkCode;
@property(nonatomic,strong) NSString *ID;
@property(nonatomic,strong) NSString *oBrandId;
@property(nonatomic,strong) NSString *posName;
@property(nonatomic,strong) NSString *remarks;
@property(nonatomic,strong) NSString *reserve;
@end







