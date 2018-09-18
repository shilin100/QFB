//
//  QFBNetWorkTool.m
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBNetWorkTool.h"
#import "LMJBaseResponse.h"
#import "MJExtension.h"

static NSString *SuccessCode = @"1";

@interface QFBNetWorkTool ()

@property (nonatomic, strong) LMJBaseRequest *request;

@end


@implementation QFBNetWorkTool

#pragma mark - 首页
/**
 获取首页的七个icon
 */
- (void)net_getHomeSevenIconblock:(void(^)(NSMutableArray<QFBHomeListModel *> *listArray, NSMutableArray *imageUrlArray, RequestState state))block;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"oBrandId"] = O_BRAND_ID;
    NSString *urlStr = URLADD(@"/appDynamic/findMenuAndRootingByObrandId.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        DLog(@"获取首页的七个icon = %@", response);
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray *lists = [QFBHomeListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"menu"]];
            NSMutableArray *imageUrls = [NSMutableArray array];
            NSArray *arr = dic[@"data"][@"routing"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                if (dic[@"url"]) {
                    [imageUrls addObject:dic[@"url"]];
                }
            }
            block(lists, imageUrls, net_succes);
        }else{
            block(nil, nil, net_fail);
        }
    }];
}

/**
 获取首页盟友消息 新增盟友 排行 激活用户
 */
- (void)net_getHomeCardMsgAndLMMessageWithId:(void(^)(QFBHomeCardModel *model, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = [kDefault objectForKey:USER_IDk];
    NSString *urlStr = URLADD(@"/user/findUserInfoByIndex.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
//        DLog(@"获取首页联盟消息 = %@", response);
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            QFBHomeCardModel *cardModel = [QFBHomeCardModel mj_objectWithKeyValues:dic[@"data"]];
            block(cardModel, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 获取首页收益
 */
- (void)net_getHomeTradeWithUserId:(void(^)(NSString *profit, NSString *rankIng, RequestState state))block
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"oBrandId"] = O_BRAND_ID;
    dic[@"userId"] = [kDefault objectForKey:USER_IDk];
    NSString *urlStr = URLADD(@"/profit/findProfitByUserId.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            block(dic[@"data"][@"profitAmount"], dic[@"data"][@"rankIng"], net_succes);
        }else{
            block(nil,nil, net_fail);
        }
    }];
}

/**
 获取个人信息
 */
- (void)net_getUserInfoWithUserID:(NSString *)userID blockRequest:(void(^)(QFBUserModel *model, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"id"] = userID;
    NSString *urlStr = URLADD(@"/user/findById.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            QFBUserModel *userModel = [QFBUserModel mj_objectWithKeyValues:dic[@"data"]];
            block(userModel, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 获取近期活动
 */
- (void)net_getRecentActWithOBrandId:(void(^)(NSMutableArray<QFBHomeActivityModel *> *modelArray, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"oBrandId"] = O_BRAND_ID;
    NSString *urlStr = URLADD(@"/merchants/findMerchants.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        DLog(@"获取近期活动 = %@", response);
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBHomeActivityModel *> *array = [QFBHomeActivityModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(array, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 搜索 获取商户信息
 */
- (void)net_searchShopMessageRealname:(NSString *)realname pasmCode:(NSString *)pasmCode blockRequest:(void(^)(NSMutableArray<QFBBusinessInfoModel *> *modelArray, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"parent_id"] = [kDefault objectForKey:USER_IDk];
    dic[@"realname"]  = realname;
    dic[@"pasmCode"]  = pasmCode;
    NSString *urlStr = URLADD(@"/psam/selectPosInformation.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBBusinessInfoModel *> *array = [QFBBusinessInfoModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(array, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}




/**
 获取近期活动详情
 */
- (void)net_getRecendDetailWithId:(NSString *)recentId blockRequest:(void(^)(RecentModel *model, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"id"] = recentId;
    NSString *urlStr = URLADD(@"/merchants/findById.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            RecentModel *recentModel = [RecentModel mj_objectWithKeyValues:dic[@"data"]];
            block(recentModel, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}


/**
 商户详情个人详情
 */
- (void)net_getShopMessageDetailWithPasmCode:(NSString *)psamCode blockRequest:(void(^)(NSDictionary *dic, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"psamCode"] = psamCode;
    NSString *urlStr = URLADD(@"/psam/findBypsamCode.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSArray *arr = dic[@"data"];
           block(arr.firstObject, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 商户详情交易明细
 */
- (void)net_getShopMessageTradeListWithPasmCode:(NSString *)psamCode blockRequest:(void(^)(NSDictionary *dic, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"psamCode"] = psamCode;
    NSString *urlStr = URLADD(@"/transaction/selectBypasmCode.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            block(dic[@"data"], net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

#pragma mark - 机器激活
/**
 获取机器激活列表
 
 @param psamCode psam码
 @param status 状态  0:未激活    1:已激活   2:未达标
 */
- (void)net_getMachineActiveWithPsamCode:(NSString *)psamCode status:(NSString *)status blockRequest:(void(^)(NSMutableArray<QFBMachineModel *> *arr, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    dic[@"oBrandId"]  = O_BRAND_ID;
    dic[@"psamCode"]  = psamCode;
    dic[@"status"]    = status;
    NSString *urlStr = URLADD(@"/psam/selectByMoney.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBMachineModel *> *array = [QFBMachineModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(array, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 激活机器
 */
- (void)net_activeMachineWithPsamId:(NSString *)psamId blockRequest:(void(^)(QFBMachineActivateModel *machineModel, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"psamId"]  = psamId;
    NSString *urlStr = URLADD(@"/posbrand/selectByposId.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            QFBMachineActivateModel *model = [QFBMachineActivateModel mj_objectWithKeyValues:dic[@"data"]];
            block(model, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 获取机器激活验证码ip
 */
- (void)net_getCheckCodeIpBlockRequest:(void(^)(NSString *codeIP, RequestState state))block
{
    NSString *urlStr = URLADD(@"/appDynamic/selectByURL.action");
    [self POST:urlStr parameters:nil completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSString *url = [NSString stringWithFormat:@"%@",dic[@"data"][@"url"]];
            block(url, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 获取激活机器验证码图片
 */
- (void)net_getActiveImageCodeWithTime:(NSString *)time psam:(NSString *)psam url:(NSString *)url BlockRequest:(void(^)(NSString *urlStr, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"time"]  = time;
    dic[@"psam"]  = psam;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",url,@"/payment_crawler/getCheckCodeImage.action"];
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSString *str = [NSString stringWithFormat:@"%@/payment_crawler/img/%@.jpg",url,time];
            block(str, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 提交验证码激活
 */
- (void)net_submitMachineActiveWithPhone:(NSString *)phone name:(NSString *)name psam:(NSString *)psam time:(NSString *)time checkCode:(NSString *)checkCode BlockRequest:(void(^)(NSString *infoStr, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlTail = @"/fieldActivation.action";
    if (time && checkCode) {
        dic[@"time"]      = time;
        dic[@"checkCode"] = checkCode;
        urlTail = @"/fieldActivationByCode.action";
    }
    dic[@"phone"] = phone;
    dic[@"name"]  = name;
    dic[@"psam"]  = psam;
    NSString *url = @"http://116.255.250.113:8080/payment_crawler";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",url,urlTail];
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            block(dic[@"msg"], net_succes);
        }else{
            block(dic[@"msg"], net_fail);
        }
    }];
}

/**
 获取直接盟友列表
 */
- (void)net_getDirectFriendListBlockRequest:(void(^)(NSMutableArray<QFBUserModel *> *usersArray, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    NSString *urlStr = URLADD(@"/user/selectByParentId.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBUserModel *> *arr = [QFBUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(arr, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 转让机器
 
 @param userId 接收人id
 @param posId pos机id
 */
- (void)net_transferMachineWithUserId:(NSString *)userId id:(NSString *)posId BlockRequest:(void(^)(NSString *infoStr, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"transferId"]  = userId;
    dic[@"id"]          = posId;
    NSString *urlStr = URLADD(@"/psam/updateMachineTransfer.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            block(dic[@"data"], net_succes);
        }else{
            block(dic[@"data"], net_fail);
        }
    }];
}

/**
 获取盟友通讯
 */
- (void)net_getFriendBooksWithUserId:(NSString *)userId card:(NSString *)card roleId:(NSString *)roleId realName:(NSString *)realName blockRequest:(void(^)(NSMutableArray<QFBUserModel *> *usersArray, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = userId;
    dic[@"card"]      = card;
    dic[@"roleId"]    = roleId;
    dic[@"realName"]  = realName;
    NSString *urlStr = URLADD(@"/test/selectAllByUserId.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBUserModel *> *arr = [QFBUserModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(arr, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 获取所有盟友角色
 */
- (void)net_getAllFriendsRoleBlockRequest:(void(^)(NSMutableArray<QFBRoleModel *> *roleArray, RequestState state))block;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"oBrandId"] = O_BRAND_ID;
    NSString *urlStr = URLADD(@"/role/selectByoBrandId.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBRoleModel *> *arr = [QFBRoleModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(arr, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

/**
 获取我的消息
 */
- (void)net_getNewsBlockRequest:(void(^)(NSMutableArray<QFBMessageModel *> *messageArray, RequestState state))block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"]    = [kDefault objectForKey:USER_IDk];
    dic[@"oBrandId"]  = O_BRAND_ID;
    NSString *urlStr = URLADD(@"/news/findNews.action");
    [self POST:urlStr parameters:dic completion:^(LMJBaseResponse *response) {
        NSDictionary *dic = response.responseObject;
        if ([SuccessCode isEqualToString:dic[@"msg"]]) {
            NSMutableArray<QFBMessageModel *> *arr = [QFBMessageModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            block(arr, net_succes);
        }else{
            block(nil, net_fail);
        }
    }];
}

@end









