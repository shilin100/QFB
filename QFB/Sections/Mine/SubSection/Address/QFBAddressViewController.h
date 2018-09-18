//
//  QFBAddressViewController.h
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBAddressModel.h"

typedef void(^block)(QFBAddressModel *model);

@interface QFBAddressViewController : UIViewController

@property (nonatomic, strong) block blockAddress;
@property (nonatomic, strong) NSString *addressID; // 外面传过来的地址 删除后传nil过去

@end
