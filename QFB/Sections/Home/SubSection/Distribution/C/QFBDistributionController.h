//
//  QFBDistributionController.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBDistributionModel.h"
#import "QFBHomeModel.h"

@interface QFBDistributionController : UIViewController

@property (nonatomic, strong) NSMutableArray<BuyMachine *> *productsArray;    //    产品array
@property (nonatomic, assign) BOOL isFree;                                    //    是否免费领取

@end
