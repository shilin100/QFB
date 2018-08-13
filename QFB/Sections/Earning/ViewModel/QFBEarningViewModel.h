//
//  QFBEarningViewModel.h
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBEarningViewModel : NSObject

@property(nonatomic,strong)RACCommand   * earningCellCommand;
@property(nonatomic,strong)RACCommand   * getDataCommand;


@end
