//
//  QFBDistributionFootView.m
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBDistributionFootView.h"

@interface QFBDistributionFootView()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button_sure;

@end

@implementation QFBDistributionFootView

+ (instancetype)initWithFrame:(CGRect)frame
{
    QFBDistributionFootView *view = [[[NSBundle mainBundle] loadNibNamed:@"QFBDistributionFootView" owner:nil options:nil] objectAtIndex:0];
    view.frame = frame;
    return view;
}

- (void)changeBtnTitleState:(double)money
{
    if (money == 0) {
        [_button_sure setTitle:@"确认领取" forState:UIControlStateNormal];
    }else{
        [_button_sure setTitle:@"确认支付" forState:UIControlStateNormal];
    }
}

- (NSString *)getNote
{
    return _textField.text;
}

- (IBAction)pressSure:(id)sender {
    if (self.block) {
        self.block(YES);
    }
}


@end
