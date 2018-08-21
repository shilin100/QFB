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

@property (nonatomic, copy) void (^addButtonClick)(NSString *countString,BuyMachine *bMachine);
@property (nonatomic, copy) void (^decreaseButtonClick)(NSString *countString,BuyMachine *bMachine);
- (void)getDataWithModel:(id)model  index:(NSInteger)index count:(NSInteger)count;

@end
