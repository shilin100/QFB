//
//  QFBRegisterStepTwoViewController.h
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    TYPE_REGISTER=0, //返回一个对象
    TYPE_FORGET_PSW=1, //返回一个数组
    TYPE_OTHER ,  //专门正对那些不规范的后台解码而设
}VCType;

@interface QFBRegisterStepTwoViewController : UIViewController

@property (nonatomic,copy) NSString *parentId;
@property (nonatomic,assign)VCType vcType;

@end
