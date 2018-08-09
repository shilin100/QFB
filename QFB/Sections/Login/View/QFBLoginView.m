//
//  QFBLoginView.m
//  QFB
//
//  Created by qqq on 2018/8/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBLoginView.h"
#import "UIView+ZFAddRectangBorder.h"


@implementation QFBLoginView

-(instancetype)init{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        bgImgView.image = [UIImage imageNamed:@"矩形 8"];
        [self addSubview:bgImgView];
        self.bgImgView = bgImgView;
        
        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];

        
        UIImageView * userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat userIconHeight = 106;//头像宽高
        userIcon.layer.cornerRadius = userIconHeight/2;
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        userIcon.layer.borderWidth = 2;
        [self addSubview:userIcon];
        self.userIcon = userIcon;
        
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(userIconHeight, userIconHeight));
            make.centerX.equalTo(self);
            make.top.mas_equalTo(@102);
        }];
        
        
        UILabel * username = [UILabel new];
        username.text = @"用户名";
        username.textColor = [UIColor whiteColor];
        username.textAlignment = NSTextAlignmentCenter;
        [self addSubview:username];
        
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.left.mas_equalTo(@50);
            make.height.mas_equalTo(@15);
            make.top.equalTo(userIcon.mas_bottom).offset(12);
        }];
        
        UIView * line = [UIView new];
        line.backgroundColor = HEXCOLOR(0xCCCCCC);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.mas_equalTo(@67);
            make.right.mas_equalTo(@-67);
            make.top.equalTo(username.mas_bottom).offset(79);
        }];

        
        UITextField * usernameTextField = [[UITextField alloc]init];
        usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        usernameTextField.textColor = [UIColor whiteColor];
        usernameTextField.font = XFont(15);
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"用户名/手机号" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                            NSFontAttributeName:usernameTextField.font
                                            }];
        usernameTextField.attributedPlaceholder = attrString;
        usernameTextField.textColor = [UIColor whiteColor];
        [self addSubview:usernameTextField];
        self.userNameTextfield = usernameTextField;
        
        [usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.left.equalTo(line.mas_left).offset(1);
            make.bottom.equalTo(line.mas_top).offset(-1);
            make.height.mas_equalTo(@20);
        }];

        
        UIView * pswLine = [UIView new];
        pswLine.backgroundColor = HEXCOLOR(0xCCCCCC);
        [self addSubview:pswLine];
        [pswLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.left.mas_equalTo(@67);
            make.right.mas_equalTo(@-67);
            make.top.equalTo(line.mas_bottom).offset(47);
        }];

        
        UITextField * pswTextField = [[UITextField alloc]init];
        pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        pswTextField.textColor = [UIColor whiteColor];
        pswTextField.font = XFont(15);
        NSAttributedString *pswAttrString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                            NSFontAttributeName:pswTextField.font
                                            }];
        pswTextField.attributedPlaceholder = pswAttrString;
        pswTextField.textColor = [UIColor whiteColor];
        pswTextField.secureTextEntry = YES;
        pswTextField.clearsOnBeginEditing = YES;
        [self addSubview:pswTextField];
        self.passWordTextfield = pswTextField;
        
        [pswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pswLine.mas_left).offset(1);
            make.right.equalTo(pswLine.mas_right).offset(-60);
            make.bottom.equalTo(pswLine.mas_top).offset(-1);
            make.height.mas_equalTo(@20);

        }];
        
        UIButton * forgetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetPswBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        forgetPswBtn.titleLabel.font = XFont(12);
        forgetPswBtn.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:forgetPswBtn];
        self.forgetPswBtn = forgetPswBtn;
        
        [forgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@55);
            make.right.equalTo(pswLine.mas_right).offset(-1);
            make.centerY.equalTo(pswTextField);
            make.height.mas_equalTo(@30);

        }];

        
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = XFont(15);
        [loginBtn ZFAddBorderWithColor:[UIColor whiteColor] Width:0];
        [loginBtn setBackgroundColor:HEXCOLOR(0xFBC059)];
        loginBtn.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:loginBtn];
        self.loginBtn = loginBtn;
        
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@38);
            make.left.mas_equalTo(@67);
            make.right.mas_equalTo(@-67);
            make.top.equalTo(pswLine.mas_bottom).offset(48);

        }];

        
        UIView * registerLine = [UIView new];
        registerLine.backgroundColor = HEXCOLOR(0xCCCCCC);
        [self addSubview:registerLine];
        [registerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@1);
            make.width.mas_equalTo(@61);
            make.centerX.equalTo(self);
            make.top.equalTo(loginBtn.mas_bottom).offset(57);
        }];

        
        UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        registerBtn.titleLabel.font = XFont(12);
        registerBtn.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:registerBtn];
        self.registerBtn = registerBtn;
        
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@55);
            make.bottom.equalTo(registerLine.mas_top).offset(-1);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(@20);

        }];

        
        
    }
    return self;
}

@end
