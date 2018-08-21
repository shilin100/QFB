//
//  SubmitView.m
//  ZFLM
//
//  Created by BoFeng on 2018/5/28.
//  Copyright © 2018年 BoFeng. All rights reserved.
//

#import "SubmitView.h"


@interface SubmitView()
{
    __weak IBOutlet UIView *_lineView;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_codeLabel;
    __weak IBOutlet UIImageView *_codeImageView;
    __weak IBOutlet UILabel *_brandNameLabel;
    __weak IBOutlet UIImageView *_smallCodeImageView;
    __weak IBOutlet UITextField *_codeTextField;
    __weak IBOutlet UITextField *_nameTextField;
    __weak IBOutlet UITextField *_phoneTextField;
    NSString *_time;
    NSString *_urlString;
    NSString *_status;
    PosMachine *_machine;
}
@end
@implementation SubmitView
- (void)getSubmitViewDataWithMachine:(PosMachine *)machine
{
    _machine = machine;
    _codeTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [_smallCodeImageView addGestureRecognizer:click];
    _status = [NSString stringWithFormat:@"%@",machine.checkCode];
    if ([_status isEqualToString:@"1"]) {
        _lineView.hidden = NO;
        _codeTextField.userInteractionEnabled = YES;
        _smallCodeImageView.hidden = NO;
        _codeTextField.hidden = NO;
        [self getCodeIp];
//        [self getCheckCodeImage];
    } else {
        _lineView.hidden = YES;
        _codeTextField.userInteractionEnabled = NO;
        _smallCodeImageView.hidden = YES;
        _codeTextField.hidden = YES;
    }
    _codeLabel.text = machine.reserve;
    _brandNameLabel.text = machine.posName;
    [self createCodeImageWithCodeString:machine.remarks];
}
- (void)clickAction
{
    [self getCheckCodeImageWithUrl:_urlString];
}
- (void)createCodeImageWithCodeString:(NSString *)codeString
{
    NSArray *filter = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@", filter);
    // 二维码过滤器
    CIFilter *filterImage = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 将二位码过滤器设置为默认属性
    [filterImage setDefaults];
    // 将文字转化为二进制
    NSData *dataImage = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    // 打印输入的属性
    //    NSLog(@"%@", filterImage.inputKeys);
    // KVC 赋值
    [filterImage setValue:dataImage forKey:@"inputMessage"];
    // 取出输出图片
    CIImage *outputImage = [filterImage outputImage];
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    // 转化图片
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    
    // 为二维码加自定义图片
    
    // 开启绘图, 获取图片 上下文<图片大小>
    UIGraphicsBeginImageContext(image.size);
    // 将二维码图片画上去
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    // 将小图片画上去
//    UIImage *smallImage = [UIImage imageNamed:@""];
//    [smallImage drawInRect:CGRectMake((image.size.width - 100) / 2, (image.size.width - 100) / 2, 100, 100)];
    // 获取最终的图片
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 显示
    _codeImageView.image = finalImage;
    
}
+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SubmitView" owner:nil options:nil] objectAtIndex:0];
}
#pragma mark - service
- (void)getCodeIp
{
    WEAKSELF;
   
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/appDynamic/selectByURL.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            NSString *url = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"url"]];
            self->_urlString = url;
            [weakSelf getCheckCodeImageWithUrl:url];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {

    }];
}
- (void)getCheckCodeImageWithUrl:(NSString *)url
{
    _time = [NSString stringWithFormat:@"%ld",[self getNowTimestamp]];
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"time"] = [kDefault objectForKey:USER_IDk];
    parameter[@"psam"] = [kDefault objectForKey:USER_IDk];
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/payment_crawler/getCheckCodeImage.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [_smallCodeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/payment_crawler/img/%@.jpg",url,_time]] placeholderImage:[UIImage imageNamed:@""]];
            _lineView.hidden = NO;
            _codeTextField.userInteractionEnabled = YES;
            _smallCodeImageView.hidden = NO;
            _codeTextField.hidden = NO;
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {
        
    }];
}
#pragma mark - method

- (IBAction)confirmButtonClicked:(id)sender
{
    [self resignResponder];
    if ([_status isEqualToString:@"1"]) {
        //    [self enterMainTabBarController];
        if (![self canSubmitHaveCode]) {
            return;
        }
        if (self.cfBlock) {
            self.cfBlock(_phoneTextField.text,_nameTextField.text,_codeLabel.text,_time,_codeTextField.text,_status);
        }
    } else {
        if (![self canSubmitNoCode]) {
            return;
        }
        if (self.cfBlock){
            self.cfBlock(_phoneTextField.text,_nameTextField.text,_codeLabel.text,_time,_codeTextField.text,_status);
        }
    }
}
- (IBAction)closeButtonClicked:(id)sender
{
    if (self.ckBlock) {
        self.ckBlock();
    }
}


#pragma mark - support
- (void)showAlert
{
    WEAKSELF;
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取验证码失败，您要重新获取吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"算了吧" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"去获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf getCheckCodeImageWithUrl:_urlString];
//        [weakSelf loginOut];
    }];
    [alertCtrl addAction:cancelAction];
    [alertCtrl addAction:continueAction];
    UIWindow *aW = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aW.rootViewController = [[UIViewController alloc]init];
    aW.windowLevel = UIWindowLevelAlert + 1;
    [aW makeKeyAndVisible];
    [aW.rootViewController presentViewController:alertCtrl animated:YES completion:nil];
//    [self presentViewController:alertCtrl animated:YES completion:nil];
}
- (void)resignResponder
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (BOOL)canSubmitNoCode
{
//    if ([VerifyHelper isEmpty:_nameTextField.text]) {
//        [self showPGToast:@"请输入姓名" second:1.];
//        return NO;
//    }
//    if ([VerifyHelper isEmpty:_phoneTextField.text]) {
//        [self showPGToast:@"请输入手机号" second:1.];
//        return NO;
//    }
    return YES;
}
- (BOOL)canSubmitHaveCode
{
//    if ([VerifyHelper isEmpty:_nameTextField.text]) {
//        [self showPGToast:@"请输入姓名" second:1.];
//        return NO;
//    }
//    if ([VerifyHelper isEmpty:_phoneTextField.text]) {
//        [self showPGToast:@"请输入手机号" second:1.];
//        return NO;
//    }
//    if ([VerifyHelper isEmpty:_codeTextField.text]) {
//        [self showPGToast:@"请输入验证码" second:1.];
//        return NO;
//    }
//    if (![self validateMobile:_phoneTextField.text]) {
//        [self showPGToast:@"手机号格式不正确" second:1.];
//        return NO;
//    }
    return YES;
}
-(NSInteger)getNowTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}
- (BOOL)validateMobile:(NSString*)mobile

{
    NSString*phoneRegex =@"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate*phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    BOOL sss;
    //    sss = [phoneTest evaluateWithObject:mobile];
    return[phoneTest evaluateWithObject:mobile];
    
}
- (void)showPGToast:(NSString *)title second:(CGFloat)second
{
//    if(title == nil || [[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]  isEqual: @""])
//    {
//        return;
//    }
//    AlertToast *toast = [AlertToast makeToast:title];
//    [toast showWithSecond:second];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
