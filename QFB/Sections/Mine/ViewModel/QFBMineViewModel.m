//
//  QFBMineViewModel.m
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBMineViewModel.h"
#import "QFBMineView.h"

@implementation QFBMineViewModel
-(instancetype)init
{
    if (self = [super init]) {
        
        
        _getDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
            parameter[@"oBrandId"] = O_BRAND_ID;
            parameter[@"userId"] = [kDefault objectForKey:USER_IDk];

            RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/profit/findProfitByUserId.action",BASEURL] withParamater:parameter];
            
            QFBMineView * containerView = input;
            [signal subscribeNext:^(id  _Nullable x) {
                NSNumber* totalEarning =  x[@"data"][@"profitAmount"];
                NSString * totalEarningStr = [NSString stringWithFormat:@"%.2lf",totalEarning.doubleValue];
                
                [containerView setMyEarnStr:totalEarningStr];
                
            }];
            
            
            NSMutableDictionary * parameter2 = [NSMutableDictionary dictionary];
//            parameter[@"oBrandId"] = O_BRAND_ID;
            parameter2[@"userId"] = [kDefault objectForKey:USER_IDk];

            RACSignal * signal2 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/user/findUserInfoByIndex.action",BASEURL] withParamater:parameter2];
            
            [signal2 subscribeNext:^(id  _Nullable x) {
                NSNumber * parterner = x[@"data"][@"friendNum"];
                NSString * parternerStr = [NSString stringWithFormat:@"%@人",parterner];;
                containerView.parternerCount.text = parternerStr;
                
                NSNumber * commercial = x[@"data"][@"activeNum"];
                containerView.activeCommercialCount.text = [NSString stringWithFormat:@"%@户",commercial];;


            }];

            NSMutableDictionary * parameter3 = [NSMutableDictionary dictionary];
            //            parameter[@"oBrandId"] = O_BRAND_ID;
            parameter3[@"id"] = [kDefault objectForKey:USER_IDk];

            RACSignal * signal3 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/user/findById.action",BASEURL] withParamater:parameter3];
            
            [signal3 subscribeNext:^(id  _Nullable x) {
                NSNumber* money =  x[@"data"][@"remarks"];
                NSString * moneyStr = [NSString stringWithFormat:@"%.2lf",money.doubleValue];
                [containerView setMyMoneyStr:moneyStr];
                
                NSNumber* rank =  x[@"data"][@"rankingStatus"];
                containerView.myRankCount.text = (rank.intValue == 0 ?@"暂无":[NSString stringWithFormat:@"%@名",rank]);

            }];
            
            RACSignal * signal4 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/index/selectByUpgrade.action",BASEURL] withParamater:parameter];
            
            [signal4 subscribeNext:^(id  _Nullable x) {
                containerView.levelLabel.text = [NSString stringWithFormat:@"V%@",x[@"data"]];
                
            }];

            
            NSMutableDictionary * parameter5 = [NSMutableDictionary dictionary];
            //            parameter[@"oBrandId"] = O_BRAND_ID;
            parameter5[@"roleId"] = [kDefault objectForKey:ROLE_IDk];
            parameter5[@"userId"] = [kDefault objectForKey:USER_IDk];

            RACSignal * signal5 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/role/findById.action",BASEURL] withParamater:parameter5];
            
            [signal5 subscribeNext:^(id  _Nullable x) {
                containerView.memberLabel.text = x[@"data"][@"roleName"];
                
            }];

            NSLog(@"%@",[kDefault objectForKey:USER_HEAD_IMGk]);
            
            [containerView.userIcon sd_setImageWithURL:[NSURL URLWithString:[kDefault objectForKey:USER_HEAD_IMGk]] placeholderImage:[UIImage imageNamed:@"我的默认头像"]];
            
            return [RACSignal empty];
        }];
        
        _mineCellCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                
                [subscriber sendNext:input];
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    //                    NSLog(@"结束了");
                }];
            }];
        }];
        
        _myServiceCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];

            parameter[@"oBrandId"] = O_BRAND_ID;

            RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/obrand/selectById.action",BASEURL] withParamater:parameter];
            
            return signal;
            
        }];
        
        _accountCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
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
