//
//  QFBUserModel.h
//  QFB
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBUserModel : QFBBaseModel<NSCoding>

@property (nonatomic, strong) NSString *nickName;       // "普通用户",
@property (nonatomic, strong) NSString *rankingStatus;  // 0,
@property (nonatomic, strong) NSString *reserve;        // <null>,
@property (nonatomic, strong) NSString *card;           // <null>,
@property (nonatomic, strong) NSString *blackNum;       // "13125098956",
@property (nonatomic, strong) NSString *clientid;       // "F64440CC-C8C3-47B7-8DAE-4D103EC8FFF8",
@property (nonatomic, strong) NSString *verificationCode;   // <null>,
@property (nonatomic, strong) NSString *realName;       // <null>,
@property (nonatomic, strong) NSString *count;          // 0,
@property (nonatomic, strong) NSString *successRecommend;   // 0,
@property (nonatomic, strong) NSString *registTime;     // "2018-07-01 13:46:01",
@property (nonatomic, strong) NSString *roleId;         // 14,
@property (nonatomic, strong) NSString *reserveTwo;     // "R67P8P",
@property (nonatomic, strong) NSString *payPwd;         // <null>,
@property (nonatomic, strong) NSString *blackAccountName;   // "13125098956",
@property (nonatomic, strong) NSString *ID;             // 18278,
@property (nonatomic, strong) NSString *topId;          // <null>,
@property (nonatomic, strong) NSString *pwd;            // "e10adc3949ba59abbe56e057f20f883e",
@property (nonatomic, strong) NSString *parentId;       // 17569,
@property (nonatomic, strong) NSString *phone;          // "18971499585",
@property (nonatomic, strong) NSString *userCode;       // <null>,
@property (nonatomic, strong) NSString *reserveThree;   // "1",
@property (nonatomic, assign) double    remarks;        // 可用余额
@property (nonatomic, strong) NSString *oBrandId;       // 5100,
@property (nonatomic, strong) NSString *userPicture;    // <null>

@end

@interface QFBRoleModel : QFBBaseModel
@property(nonatomic,strong) NSString  * ID;
@property(nonatomic,strong) NSString  * recommendJurisdiction;
@property(nonatomic,strong) NSString  * reserveOne;
@property(nonatomic,strong) NSString  * reserveFour;
@property(nonatomic,strong) NSString  * reserveFive;
@property(nonatomic,strong) NSString  * oBrandId;
@property(nonatomic,strong) NSString  * reserveTwo;
@property(nonatomic,strong) NSString  * activeJurisdiction;
@property(nonatomic,strong) NSString  * proposeJurisdiction;
@property(nonatomic,strong) NSString  * price;
@property(nonatomic,strong) NSString  * profitJurisdiction;
@property(nonatomic,strong) NSString  * createTime;
@property(nonatomic,strong) NSString  * roleName;
@property(nonatomic,strong) NSString  * modifyTime;
@property(nonatomic,strong) NSString  * remarks;
@property(nonatomic,strong) NSString  * reserve;
@property(nonatomic,strong) NSString  * reserveThree;
@end





