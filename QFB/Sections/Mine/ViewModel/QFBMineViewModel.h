//
//  QFBMineViewModel.h
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBMineViewModel : NSObject
@property(nonatomic,strong)RACCommand   * mineCellCommand;
@property(nonatomic,strong)RACCommand   * getDataCommand;
@property(nonatomic,strong)RACCommand   * myServiceCommand;
@property(nonatomic, strong, readonly) RACCommand *accountCommand;

@end
