//
//  QFBInvitingTitleView.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBInvitingTitleView.h"

@interface QFBInvitingTitleView ()

@property (weak, nonatomic) IBOutlet UILabel *label_left;
@property (weak, nonatomic) IBOutlet UILabel *label_right;
@property (weak, nonatomic) IBOutlet UIView *view_line;

@end


@implementation QFBInvitingTitleView

+ (instancetype)initWithFrame:(CGRect)frame leftText:(NSString *)leftStr right:(NSString *)rightStr
{
    QFBInvitingTitleView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] objectAtIndex:0];
    view.frame = frame;
    view.label_left.text = leftStr;
    view.label_right.text = rightStr;
    return view;
}

- (void)changeTitle:(NSString *)title
{
    _label_right.text = title;
}

- (void)hiddenLine
{
    _view_line.hidden = YES;
}

@end




