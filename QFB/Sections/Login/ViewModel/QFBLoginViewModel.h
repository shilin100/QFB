//
//  QFBLoginViewModel.h
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBLoginViewModel : NSObject
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, strong, readonly) RACCommand *loginCommand;
@property(nonatomic, strong, readonly) RACCommand *getBgImgCommand;

@property(nonatomic, strong, readonly) RACSignal *loginBtnEnable;

@end
