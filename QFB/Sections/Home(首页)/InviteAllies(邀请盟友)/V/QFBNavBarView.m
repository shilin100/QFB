//
//  QFBNavBarView.m
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBNavBarView.h"
#import "DCSpeedy.h"

@interface QFBNavBarView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;

@end

@implementation QFBNavBarView

+ (instancetype)initWithFrame:(CGRect)frame
{
    QFBNavBarView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] objectAtIndex:0];
    view.frame = frame;
    return view;
}

- (IBAction)pressBack:(id)sender {
    [[DCSpeedy dc_getCurrentVC].navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressUpdate:(id)sender {
    if (self.blockShare) {
        self.blockShare(YES);
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    _imageTop.constant = 0;
    
}

@end






