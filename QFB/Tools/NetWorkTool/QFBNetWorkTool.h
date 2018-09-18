//
//  QFBNetWorkTool.h
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

typedef NS_ENUM(NSInteger, RequestState) {
    net_succes,
    net_fail,
    net_noNetwork,
};

#import "LMJBaseRequest.h"

@interface QFBNetWorkTool : LMJBaseRequest

#pragma mark - **************** 首页 **********************
/**
 获取首页的七个icon
 */
- (void)net_getHomeSevenIconblock:(void(^)(NSMutableArray<QFBHomeListModel *> *listArray, NSMutableArray *imageUrlArray, RequestState state))block;

/**
 获取首页盟友消息 新增盟友 排行 激活用户
 */
- (void)net_getHomeCardMsgAndLMMessageWithId:(void(^)(QFBHomeCardModel *model, RequestState state))block;

/**
 获取首页收益
 */
- (void)net_getHomeTradeWithUserId:(void(^)(NSString *profit, NSString *rankIng, RequestState state))block;

/**
 获取个人信息
 */
- (void)net_getUserInfoWithUserID:(NSString *)userID blockRequest:(void(^)(QFBUserModel *model, RequestState state))block;

/**
 获取近期活动
 */
- (void)net_getRecentActWithOBrandId:(void(^)(NSMutableArray<QFBHomeActivityModel *> *modelArray, RequestState state))block;

/**
 搜索/获取商户信息
 */
- (void)net_searchShopMessageRealname:(NSString *)realname pasmCode:(NSString *)pasmCode blockRequest:(void(^)(NSMutableArray<QFBBusinessInfoModel *> *modelArray, RequestState state))block;

/**
 商户详情个人详情
 */
- (void)net_getShopMessageDetailWithPasmCode:(NSString *)psamCode blockRequest:(void(^)(NSDictionary *dic, RequestState state))block;

/**
 商户详情交易明细
 */
- (void)net_getShopMessageTradeListWithPasmCode:(NSString *)psamCode blockRequest:(void(^)(NSDictionary *dic, RequestState state))block;

/**
 获取近期活动详情id
 */
- (void)net_getRecendDetailWithId:(NSString *)recentId blockRequest:(void(^)(RecentModel *model, RequestState state))block;

#pragma mark - **************** 机器激活 ****************
/**
 获取机器激活列表
 
 @param psamCode psam码
 @param status 状态  0:未激活    1:已激活   2:未达标
 */
- (void)net_getMachineActiveWithPsamCode:(NSString *)psamCode status:(NSString *)status blockRequest:(void(^)(NSMutableArray<QFBMachineModel *> *arr, RequestState state))block;

/**
 激活机器
 
 @param psamId psamid
 */
- (void)net_activeMachineWithPsamId:(NSString *)psamId blockRequest:(void(^)(QFBMachineActivateModel *machineModel, RequestState state))block;

/**
 获取机器激活验证码ip
 */
- (void)net_getCheckCodeIpBlockRequest:(void(^)(NSString *codeIP, RequestState state))block;

/**
 获取激活机器验证码图片
 */
- (void)net_getActiveImageCodeWithTime:(NSString *)time psam:(NSString *)psam url:(NSString *)url BlockRequest:(void(^)(NSString *urlStr, RequestState state))block;

/**
 提交验证码激活
 
 @param phone 手机号
 @param name 姓名
 @param psam psam码
 @param time 时间
 @param checkCode 验证码
 */
- (void)net_submitMachineActiveWithPhone:(NSString *)phone name:(NSString *)name psam:(NSString *)psam time:(NSString *)time checkCode:(NSString *)checkCode BlockRequest:(void(^)(NSString *infoStr, RequestState state))block;

/**
 获取直接盟友列表
 */
- (void)net_getDirectFriendListBlockRequest:(void(^)(NSMutableArray<QFBUserModel *> *usersArray, RequestState state))block;

/**
 转让机器
 
 @param userId 接收人id
 @param posId pos机id
 */
- (void)net_transferMachineWithUserId:(NSString *)userId id:(NSString *)posId BlockRequest:(void(^)(NSString *infoStr, RequestState state))block;

#pragma mark - **************** 盟友通讯 ****************
/**
 获取盟友通讯
 
 @param userId 用户id
 @param card 1已经实名，-1未实名， 空（全部盟友）
 @param roleId 角色id
 @param realName 真实姓名
 */
- (void)net_getFriendBooksWithUserId:(NSString *)userId card:(NSString *)card roleId:(NSString *)roleId realName:(NSString *)realName blockRequest:(void(^)(NSMutableArray<QFBUserModel *> *usersArray, RequestState state))block;

/**
 获取所有盟友角色
 */
- (void)net_getAllFriendsRoleBlockRequest:(void(^)(NSMutableArray<QFBRoleModel *> *roleArray, RequestState state))block;

#pragma mark - **************** 我的消息 ****************
/**
 获取我的消息
 */
- (void)net_getNewsBlockRequest:(void(^)(NSMutableArray<QFBMessageModel *> *messageArray, RequestState state))block;


@end


















