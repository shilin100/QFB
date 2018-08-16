//
//  QFBHomeViewModel.h
//  QFB
//
//  Created by apple on 2018/8/9.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBHomeViewModel : NSObject

@property(nonatomic,strong)RACCommand   * earningCellCommand;
@property(nonatomic,strong)RACCommand   * getDataCommand;


@end
