//
//  QFBEarningViewModel.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBEarningViewModel.h"
#import "QFBEarningView.h"

@implementation QFBEarningViewModel

-(instancetype)init
{
    if (self = [super init]) {
        
        
        _getDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

            
            NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
            parameter[@"oBrandId"] = O_BRAND_ID;
            parameter[@"userId"] = [kDefault objectForKey:USER_IDk];

            RACSignal * signal = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/billDetailController/selectAllPrice.action",BASEURL] withParamater:parameter];
            
            QFBEarningView * containerView = input;
            [signal subscribeNext:^(id  _Nullable x) {
                NSNumber* totalEarning =  x[@"data"][@"Allcountprice"];
                NSString * totalEarningStr = [NSString stringWithFormat:@"%.0ld",(long)totalEarning.integerValue];
                [containerView setTotalEarningCountStr:totalEarningStr];
                
                NSNumber* personal =  x[@"data"][@"countprice"];
                NSNumber* team =  x[@"data"][@"countprice1"];
                NSNumber* brand =  x[@"data"][@"countprice2"];

                
                [containerView creatChartWith:personal.floatValue :team.floatValue :brand.floatValue];
                
            }];
            
            
            RACSignal * signal2 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/index/selectByUpgrade.action",BASEURL] withParamater:parameter];

            [signal2 subscribeNext:^(id  _Nullable x) {
                [containerView changeLevel:x[@"data"]];
                
            }];

//            http://fxapp.fengzhuan.org/payment_union/
            RACSignal * signal3 = [QFBNetTool postWithURL:[NSString stringWithFormat:@"%@/profit/selectDescProfit.action",BASEURL] withParamater:parameter];
            
            [signal3 subscribeNext:^(id  _Nullable x) {
                [containerView setBeyondPartnerStr:x[@"data"]];

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
