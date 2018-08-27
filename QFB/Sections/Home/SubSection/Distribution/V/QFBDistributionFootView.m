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

@end

@implementation QFBDistributionFootView

+ (instancetype)initWithFrame:(CGRect)frame
{
    QFBDistributionFootView *view = [[[NSBundle mainBundle] loadNibNamed:@"QFBDistributionFootView" owner:nil options:nil] objectAtIndex:0];
    view.frame = frame;
    return view;
}

- (IBAction)pressSure:(id)sender {
    if (self.block) {
        self.block(YES);
    }
}


@end
