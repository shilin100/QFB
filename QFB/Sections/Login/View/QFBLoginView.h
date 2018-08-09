//
//  QFBLoginView.h
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBLoginView : UIView
@property(nonatomic,strong)UITextField *userNameTextfield;
@property(nonatomic,strong)UITextField *passWordTextfield;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIButton *forgetPswBtn;
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIImageView *userIcon;

@end
