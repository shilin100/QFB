//
//  QFBHomeActivityModel.h
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"

@interface QFBHomeActivityModel : QFBBaseModel

@property (nonatomic, strong) NSString *address;        // "全国",
@property (nonatomic, strong) NSString *phone;          // "",
@property (nonatomic, strong) NSString *ID;             // 7,
@property (nonatomic, strong) NSString *merchantImg;    // "http://fxapp.fengzhuan.org/merchants/1526889239915.jpg",
@property (nonatomic, strong) NSString *title;          // "激活秒返现200+10+5",
@property (nonatomic, strong) NSString *endTime;        // "2018-09-30 15:52:57",
@property (nonatomic, strong) NSString *attending;      // "全富宝合伙人",
@property (nonatomic, strong) NSString *merchantType;  // 0,
@property (nonatomic, strong) NSString *metting;       // "1.在全富宝合伙人端订购机器，订购参与激活返现活动，邮寄包邮  2.首笔信用卡刷
@property (nonatomic, strong) NSString *startTime;      // "2018-05-18 15:52:44",
@property (nonatomic, strong) NSString *oBrandId;       // 5100

@end
