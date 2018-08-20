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
    TYPE_EDIT=0, //返回一个对象
    TYPE_ADD=1, //返回一个数组
    TYPE_OTHER ,  //专门正对那些不规范的后台解码而设
}AddressType;

@interface QFBAddAddressViewController : UIViewController

-(void)setVCEditStyleWithModel:(QFBAddressModel*)model;
@property(nonatomic,assign)AddressType addressType;

@end
