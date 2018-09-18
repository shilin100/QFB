//
//  QFBAllianceViewModel.m
//  QFB
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAllianceViewModel.h"
#import "QFBAllianceView.h"

@implementation QFBAllianceViewModel

-(instancetype)init
{
    if (self = [super init]) {
        // 网络请求
        _getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
            parameter[@"parentId"] = [kDefault objectForKey:USER_IDk];
            parameter[@"startTime"] = [self getCurrentTimes];
            parameter[@"endTime"] = [self getNextCurrentTimes];
            //  获取累计盟友数、直接盟友、间接盟友
            RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/transaction/selectByPos.action",BASEURL] withParamater:parameter];
            QFBAllianceView * containerView = input;
            [signal subscribeNext:^(id  _Nullable x) {
                [containerView getTransactionDict:x[@"data"]];
            }];
            
            //  今日新增盟友数、今日新增直接盟友、今日新增间接盟友、团队激活商户数、今日新增盟友、累计激活商户
            RACSignal * signal2 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/transaction/selectByPos2.action",BASEURL] withParamater:parameter];
            [signal2 subscribeNext:^(id  _Nullable x) {
                [containerView getTodayAddFriendsDict:x[@"data"]];
            }];
            
            //  本月直营商户交易额,//直营累计激活商户//团队累计激活商户
            RACSignal * signal3 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/transaction/selectByPos1.action",BASEURL] withParamater:parameter];
            [signal3 subscribeNext:^(id  _Nullable x) {
                [containerView getThisMonthMakeMoneyDict:x[@"data"]];
            }];
            
            //  获取本月团队商户交易额
            NSMutableDictionary * parameter1 = [NSMutableDictionary dictionary];
            parameter[@"parentId"] = [kDefault objectForKey:USER_IDk];
            RACSignal * signal4 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/transaction/selectAllMonthByUserId.action",BASEURL] withParamater:parameter1];
            [signal4 subscribeNext:^(id  _Nullable x) {
                [containerView getTheTeamMonthBusinessPriceDict:x[@"data"]];
            }];
            
            return [RACSignal empty];
        }];
        
        
        // 点击事件
        _earningCellCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    //                    NSLog(@"结束了");
                }];
            }];
        }];
    }
    
    return self;
}
#pragma mark - support
-(NSString * )getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}
-(NSString * )getNextCurrentTimes
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *datenow = [NSDate date];
    
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:datenow];//后一天
    
    NSString *currentTimeString = [formatter stringFromDate:nextDay];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}
@end









