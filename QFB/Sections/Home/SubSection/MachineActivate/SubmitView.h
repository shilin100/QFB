//
//  SubmitView.h
//  ZFLM
//
//  Created by BoFeng on 2018/5/28.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBHomeModel.h"
typedef void(^closeBlock)(void);
typedef void(^confirmBlock)(NSString *phone,NSString *name, NSString *psam, NSString *time, NSString *checkCode,NSString *status);

@interface SubmitView : UIView
@property (nonatomic, copy) closeBlock ckBlock;
@property (nonatomic, copy) confirmBlock cfBlock;
- (void)getSubmitViewDataWithMachine:(PosMachine *)machine;
+ (instancetype)loadFromNib;
@end
