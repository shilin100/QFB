//
//  QFBHomeModel.h
//  QFB
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootingModel : NSObject

/** 首页顶部轮播图片模型 */
/** oBrandId */
@property (nonatomic,copy) NSString *oBrandId;
/** 本地图片链接地址 */
@property (nonatomic,copy) NSString *url;


@end

@interface MenuModel : NSObject

@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *url;


@end

@interface BuyMachine : NSObject
@property(nonatomic,strong) NSString * roleId;
@property(nonatomic,strong) NSString * remarks;
@property(nonatomic,strong) NSString * ID;
@property(nonatomic,assign) double     price;           // 价格
@property(nonatomic,assign) int        count;           // 激活数量
@property(nonatomic,strong) NSString * remarksTwo;      // 图片
@property(nonatomic,strong) NSString * posTypeId;
@property(nonatomic,assign) double     remarksThree;    // 返现
@property(nonatomic,strong) NSString * oBrandId;
@property(nonatomic,assign) int        selectorCount;   // 已选数量
@end

@interface PosMachine : NSObject
@property(nonatomic,strong) NSString * checkCode;
@property(nonatomic,strong) NSString * id;
@property(nonatomic,strong) NSString * oBrandId;
@property(nonatomic,strong) NSString * posName;
@property(nonatomic,strong) NSString * remarks;
@property(nonatomic,strong) NSString * reserve;
@end

@interface FriendUpgrade : NSObject
@property(nonatomic,strong) NSString * id;
@property(nonatomic,strong) NSString * recommendJurisdiction;
@property(nonatomic,strong) NSString * reserveOne;
@property(nonatomic,strong) NSString * reserveFour;
@property(nonatomic,strong) NSString * reserveFive;
@property(nonatomic,strong) NSString * oBrandId;
@property(nonatomic,strong) NSString * reserveTwo;
@property(nonatomic,strong) NSString * activeJurisdiction;
@property(nonatomic,strong) NSString * proposeJurisdiction;
@property(nonatomic,strong) NSString * price;
@property(nonatomic,strong) NSString * profitJurisdiction;
@property(nonatomic,strong) NSString * createTime;
@property(nonatomic,strong) NSString * roleName;
@property(nonatomic,strong) NSString * modifyTime;
@property(nonatomic,strong) NSString * remarks;
@property(nonatomic,strong) NSString * reserve;
@property(nonatomic,strong) NSString * reserveThree;
@end


@interface RecentModel : NSObject
@property(nonatomic,strong) NSString  * address;
@property(nonatomic,strong) NSString  * phone;
@property(nonatomic,strong) NSString  * ID;
@property(nonatomic,strong) NSString  * merchantImg;
@property(nonatomic,strong) NSString  * title;
@property(nonatomic,strong) NSString  * endTime;
@property(nonatomic,strong) NSString  * ext;
@property(nonatomic,strong) NSString  * merchantType;
@property(nonatomic,strong) NSString  * attending;
@property(nonatomic,strong) NSString  * startTime;
@property(nonatomic,strong) NSString  * metting;
@end




