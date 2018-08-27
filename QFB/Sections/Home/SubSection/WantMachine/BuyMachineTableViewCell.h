//
//  BuyMachineTableViewCell.h
//  ZFLM
//
//  Created by BoFeng on 2018/5/25.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBHomeModel.h"
@interface BuyMachineTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^buttonClick)(BOOL isClick);

- (void)getDataWithModel:(BuyMachine *)model;

@end
