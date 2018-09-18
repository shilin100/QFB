//
//  QFBAddAddressViewController.h
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFBAddressModel;
typedef enum {
    TYPE_EDIT=0, // 编辑地址
    TYPE_ADD=1,  // 添加地址
    TYPE_OTHER , // 其他
}AddressType;

@interface QFBAddAddressViewController : UIViewController

-(void)setVCEditStyleWithModel:(QFBAddressModel*)model;

@property(nonatomic,assign)AddressType addressType;

@end
