//
//  QFBMachineTransferController.h
//  QFB
//
//  Created by qqq on 2018/9/12.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockTransfer)(BOOL isSuccess);

@interface QFBMachineTransferController : UIViewController

@property (nonatomic, weak) QFBMachineModel *myMachineModel;
@property (nonatomic, strong) blockTransfer block;          // 转让成功

@end
