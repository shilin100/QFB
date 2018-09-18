//
//  QFBActivateMachineView.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBActivateMachineView.h"

@interface QFBActivateMachineView()

@property (weak, nonatomic) IBOutlet UILabel *label_pasm;
@property (weak, nonatomic) IBOutlet UIImageView *image_code;   // 二维码
@property (weak, nonatomic) IBOutlet UILabel *label_brandName;  // pos机的名字
@property (weak, nonatomic) IBOutlet UITextField *text_name;
@property (weak, nonatomic) IBOutlet UITextField *text_phone;
@property (weak, nonatomic) IBOutlet UITextField *text_code;
@property (weak, nonatomic) IBOutlet UIImageView *image_vCode;  // 验证码
@property (weak, nonatomic) IBOutlet UIButton *button_close;
@property (weak, nonatomic) IBOutlet UIButton *button_sure;
@property (weak, nonatomic) IBOutlet UIView *view_lastLine;
@property (nonatomic, strong) NSString *urlCode;    // 请求验证码的
@property (nonatomic, strong) QFBNetWorkTool *myNetWork;
@property (nonatomic, strong) QFBMachineActivateModel *myModel;
@property (nonatomic, strong) NSString *activateTime;      // 请求激活的时间戳

@end

@implementation QFBActivateMachineView

+ (instancetype)initWithFrame:(CGRect)frame model:(QFBMachineActivateModel *)model
{
    QFBActivateMachineView *view = [[NSBundle mainBundle] loadNibNamed:@"QFBActivateMachineView" owner:nil options:nil].lastObject;
    view.myNetWork = [[QFBNetWorkTool alloc] init];
    view.frame = frame;
    view.layer.cornerRadius = 5;
    view.button_sure.layer.cornerRadius = 5;
    view.button_close.layer.cornerRadius = 5;
    [view loadMachineActivateModel:model];
    [view createAnimation];
    return view;
}

- (void)loadMachineActivateModel:(QFBMachineActivateModel *)model
{
    _myModel = model;
    _label_pasm.text = model.reserve;
    _label_brandName.text = model.posName;
    UIImage *codeImag = [DCSpeedy dc_getQRCode:model.remarks size:self.image_code.mj_w];
    self.image_code.image = codeImag;
    if ([@"0" isEqualToString:model.checkCode]) {      // 0:不需要验证码
        _image_vCode.hidden = YES;
        _text_code.hidden = YES;
        _view_lastLine.hidden = YES;
    }else{
        _image_vCode.userInteractionEnabled = YES;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [_image_vCode addGestureRecognizer:click];
        [self getCodeIP];
    }
}


/**
 获取激活码图片
 */
- (void)clickAction
{
    if (self.urlCode == nil) {
        return ;
    }
    _activateTime = [DCSpeedy getNowTimestamp];
    WEAKSELF;
    [self.myNetWork net_getActiveImageCodeWithTime:_activateTime psam:_myModel.reserve url:_urlCode BlockRequest:^(NSString *urlStr, RequestState state) {
        if (state == net_succes) {
            [weakSelf.image_vCode sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        }
    }];
}


/**
 激活机器
 */
- (void)activeMachine
{
    if (_text_name.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入姓名！"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (_text_phone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入电话！"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (_text_code.text.length == 0 && _text_code.isHidden == NO) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码！"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if (![RegularHelperUtil checkTelNumber:_text_phone.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号！"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    [SVProgressHUD showWithStatus:@"正在激活,请稍后..."];
    WEAKSELF;
    [self.myNetWork net_submitMachineActiveWithPhone:_text_phone.text name:_text_name.text psam:_myModel.reserve time:_activateTime checkCode:_text_code.text BlockRequest:^(NSString *infoStr, RequestState state) {
        if (state == net_succes) {
            if (weakSelf.block) {
                weakSelf.block(1);
            }
            [SVProgressHUD showSuccessWithStatus:infoStr];
        }else{
            if (weakSelf.block) {
                if ([@"验证码错误" isEqualToString:infoStr]) {
                    weakSelf.block(3);
                    [weakSelf clickAction]; // 刷新验证码
                }else{
                    weakSelf.block(2);      // 错误
                }
            }
            [SVProgressHUD showErrorWithStatus:infoStr];
        }
        [SVProgressHUD dismissWithDelay:1.5];
    }];
}


- (void)getCodeIP
{
    WEAKSELF;
    [self.myNetWork net_getCheckCodeIpBlockRequest:^(NSString *codeIP, RequestState state) {
        if (state == net_succes) {
            weakSelf.urlCode = codeIP;
            [weakSelf clickAction];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败!"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }];
}

- (void)createAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.3; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = NO; // 动画结束时执行逆动画
    animation.removedOnCompletion = NO;  // 动画终了后不返回初始状态
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue   = [NSNumber numberWithFloat:1.0];
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];  // 动画先加速后减速
    [self.layer addAnimation:animation forKey:nil];
}

// 点击取消
- (IBAction)pressClose:(id)sender {
    if (self.block) {
        self.block(0);
    }
}

// 点击确认
- (IBAction)pressSure:(id)sender {
    [self activeMachine];
}

- (void)dealloc
{
    [self.layer removeAllAnimations];
}


@end




