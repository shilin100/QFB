//
//  QFBRegisterStepTwoViewController.h
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    TYPE_REGISTER=0,
    TYPE_FORGET_PSW=1,
    TYPE_OTHER ,  
}VCType;

@interface QFBRegisterStepTwoViewController : UIViewController

@property (nonatomic,copy) NSString *parentId;
@property (nonatomic,assign)VCType vcType;

@end
