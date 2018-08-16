//
//  QFBHomeViewModel.m
//  QFB
//
//  Created by apple on 2018/8/9.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeViewModel.h"
#import "QFBHomeView.h"
#import "QFBHomeModel.h"

@implementation QFBHomeViewModel

-(instancetype)init
{
    if (self = [super init]) {
        
        
        _getDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
            parameter[@"oBrandId"] = O_BRAND_ID;
            
            RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/appDynamic/findMenuAndRootingByObrandId.action",BASEURL] withParamater:parameter];
            
            QFBHomeView * containerView = input;
            [signal subscribeNext:^(id  _Nullable x) {
                
                //NSMutableArray * arr = [NSMutableArray array];
                
//                for (NSDictionary * dict in x[@"data"][@"routing"]) {
//                    NSString * str = dict[@"url"];
//                    [arr addObject:str];
//                }
                [containerView MenuAndRooting:[RootingModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"routing"]] MenuArray:[MenuModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"menu"]]];
                
            }];
            
            //18804余额
            NSMutableDictionary * parameter1 = [NSMutableDictionary dictionary];
            parameter1[@"id"] = @"18804";
            RACSignal * signal2 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/user/findById.action",BASEURL] withParamater:parameter1];
            
            [signal2 subscribeNext:^(id  _Nullable x) {
                
                [containerView getBalanceStr:x[@"data"][@"remarks"]];
            }];
            //收益
            parameter[@"userId"] = @"18804";
            RACSignal * signal3 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/profit/findProfitByUserId.action",BASEURL] withParamater:parameter];
            
            [signal3 subscribeNext:^(id  _Nullable x) {
                
                [containerView getEarningsStr:x[@"data"][@"profitAmount"]];
            }];
            //盟友
            NSMutableDictionary * parameter4 = [NSMutableDictionary dictionary];
            parameter4[@"userId"] = @"18804";
            RACSignal * signal4 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/user/findUserInfoByIndex.action",BASEURL] withParamater:parameter4];
            
            [signal4 subscribeNext:^(id  _Nullable x) {
                
                [containerView getAddFriendStr:x[@"data"][@"friendNum"] MyRankingStr:@"暂无" AddUserStr:x[@"data"][@"activeNum"]];
            }];
            
            
           
            
            
            
            return [RACSignal empty];
        }];
        
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

@end
