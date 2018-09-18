//
//  NoDataView.m
//  BQG
//
//  Created by BoFeng on 16/8/8.
//  Copyright © 2016年 BoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView

- (void)initWithTitle:(NSString *)aTitle;

- (void)showNoDataViewOnView:(UIView *)superView;

- (void)removeNoOrderView;

- (void)modifyNoDataViewTop:(CGFloat)top;

- (void)initWithTitle:(NSString *)aTitle image:(NSString *)imageName;

+ (instancetype)loadFromNib;
@end
