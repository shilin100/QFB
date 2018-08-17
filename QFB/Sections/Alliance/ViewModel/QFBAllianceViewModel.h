//
//  QFBAllianceViewModel.h
//  QFB
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBAllianceViewModel : NSObject

@property(nonatomic,strong)RACCommand   * earningCellCommand;
@property(nonatomic,strong)RACCommand   * getDataCommand;

@end
