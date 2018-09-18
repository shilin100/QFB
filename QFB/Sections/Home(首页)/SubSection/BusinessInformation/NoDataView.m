//
//  NoDataView.m
//  BQG
//
//  Created by BoFeng on 16/8/8.
//  Copyright © 2016年 BoFeng. All rights reserved.
//

#import "NoDataView.h"
@interface NoDataView ()
{
    __weak IBOutlet UILabel *_msgLabel;
    __weak IBOutlet NSLayoutConstraint *_topCons;
    __weak IBOutlet UIImageView *_imageView;
}
@end

@implementation NoDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initWithTitle:(NSString *)aTitle
{
    _msgLabel.text = aTitle;
}

- (void)initWithTitle:(NSString *)aTitle image:(NSString *)imageName
{
    [self initWithTitle:aTitle];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)showNoDataViewOnView:(UIView *)superView
{
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(0);
        make.top.equalTo(superView).with.offset(0);
        make.right.equalTo(superView).with.offset(0);
        make.bottom.equalTo(superView).with.offset(0);
    }];
}

- (void)modifyNoDataViewTop:(CGFloat)top
{
    _topCons.constant = top;
}

- (void)removeNoOrderView
{
    if (self) {
        [self removeFromSuperview];
    }
}

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NoDataView" owner:nil options:nil] objectAtIndex:0];
}
@end
