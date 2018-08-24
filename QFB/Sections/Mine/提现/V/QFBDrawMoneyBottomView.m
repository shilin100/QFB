//
//  QFBDrawMoneyBottomView.m
//  QFB
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDrawMoneyBottomView.h"

@interface QFBDrawMoneyBottomView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *text_money;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_number;
@property (weak, nonatomic) IBOutlet UILabel *label_explain;
@property (weak, nonatomic) IBOutlet UIButton *button_sure;

@end

@implementation QFBDrawMoneyBottomView

+ (instancetype)initWithFrame:(CGRect)frame
{
    QFBDrawMoneyBottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"QFBDrawMoneyBottomView" owner:nil options:nil] objectAtIndex:0];
    view.button_sure.layer.cornerRadius = 5;
    view.text_money.delegate = view;
    view.frame = frame;
    return view;
}

- (double)getMoney
{
    
    return [_text_money.text doubleValue];
}

- (void)loadName:(NSString *)name number:(NSString *)num rate:(NSString *)rate
{
    _label_name.text    = name;
    _label_number.text  = num;
    _label_explain.text = rate;
//    _label_explain.text = [NSString stringWithFormat:@"提现说明  每笔提现需要扣除%@元手续费，每笔最低3元手续费 激活机器将额外收取%@的税收",rate,taxRevenue];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (IBAction)pressDrawMoney:(id)sender {
    if (self.pressSure) {
        self.pressSure(YES);
    }
}

//textField.text 输入之前的值 string 输入的字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isHaveDian = YES;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                if (single == '0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    NSInteger tt = range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        //[self alertView:@"亲，您最多输入两位小数"];
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}



@end





