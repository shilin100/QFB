//
//  ConfirmPersonViewController.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "ConfirmPersonViewController.h"
#import <FBFramework/FBFramework.h>
#import "CertificationMessageViewController.h"

@interface ConfirmPersonViewController ()<UITextFieldDelegate>

@end

@implementation ConfirmPersonViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"身份认证";
    if ([VerifyHelper isEmpty:[kDefault objectForKey:USER_IDCARDk]]) {
        [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
        _nameTextField.text = @"";
        _phoneTextField.text = @"";
        _idCardTextField.text = @"";
        _nameTextField.userInteractionEnabled = YES;
        _phoneTextField.userInteractionEnabled = YES;
        _idCardTextField.userInteractionEnabled = YES;
    } else {
        _nameTextField.text = [kDefault objectForKey:USER_REALNAMEk];
        _phoneTextField.text = [kDefault objectForKey:USER_PHONE];
        _idCardTextField.text = [kDefault objectForKey:USER_IDCARDk];
        [_submitButton setTitle:@"重置修改" forState:UIControlStateNormal];
        _nameTextField.userInteractionEnabled = NO;
        _phoneTextField.userInteractionEnabled = NO;
        _idCardTextField.userInteractionEnabled = NO;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
#pragma mark - UI
- (void)initUI
{
    _nameTextField.delegate = self;
    _phoneTextField.delegate = self;
    _idCardTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _idCardTextField.keyboardType = UIKeyboardTypeASCIICapable;
}
#pragma mark - service
- (void)confirmPerson
{
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"realName"] = _nameTextField.text;
    parameter[@"card"] = _idCardTextField.text;
    parameter[@"phone"] = _phoneTextField.text;
    parameter[@"blackNumber"] = @"";
    parameter[@"blackAccountName"] = @"";
    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/user/updateCode.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
        [SVProgressHUD showSuccessWithStatus:@"身份认证成功"];
            [kDefault setObject:self->_nameTextField.text  forKey:USER_REALNAMEk];
            [kDefault setObject:self->_idCardTextField.text  forKey:USER_IDCARDk];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }
        
    } andFaild:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmButtonClicked:(id)sender {
    [self resignResponder];
    if ([_submitButton.titleLabel.text isEqualToString:@"确认提交"]) {
        if (![self canSubmit]) {
            return;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self confirmPerson];
    } else {
        //[self enterCertificationMessageViewControllerWithTitle:@"身份认证"];
        CertificationMessageViewController * c_vc = [[CertificationMessageViewController alloc] init];
        c_vc.titleString = @"身份认证";
        [self.navigationController pushViewController:c_vc animated:YES];
    }
}
- (void)resignResponder
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (BOOL)canSubmit
{
    if ([VerifyHelper isEmpty:_nameTextField.text]) {
        //[self showPGToast:@"姓名不能为空" second:1.];
        return NO;
    }
    if ([VerifyHelper isEmpty:_phoneTextField.text]) {
        //[self showPGToast:@"手机号不能为空" second:1.];
        return NO;
    }if ([VerifyHelper isEmpty:_idCardTextField.text]) {
        //[self showPGToast:@"身份证号不能为空" second:1.];
        return NO;
    }
    if (![self isVaildRealName:_nameTextField.text]) {
        //[self showPGToast:@"中文姓名格式不正确" second:1.];
        return NO;
    }
    if (![self validateMobile:_phoneTextField.text]) {
        //[self showPGToast:@"手机号格式不正确" second:1.];
        return NO;
    }
    if (![self checkUserID:_idCardTextField.text]) {
        //[self showPGToast:@"身份证号格式不正确" second:1.];
        return NO;
    }
    return YES;
}
- (BOOL)isVaildRealName:(NSString *)realName
{
    if ([VerifyHelper isEmpty:realName]) return NO;
    
    NSRange range1 = [realName rangeOfString:@"·"];
    NSRange range2 = [realName rangeOfString:@"•"];
    if(range1.location != NSNotFound ||   // 中文 ·
       range2.location != NSNotFound )    // 英文 •
    {
        //一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 15)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
    else
    {
        //一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 8) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
}

- (BOOL)validateMobile:(NSString*)mobile
{
    NSString*phoneRegex =@"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate*phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    BOOL sss;
    //    sss = [phoneTest evaluateWithObject:mobile];
    return[phoneTest evaluateWithObject:mobile];
}
-(BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}
@end
