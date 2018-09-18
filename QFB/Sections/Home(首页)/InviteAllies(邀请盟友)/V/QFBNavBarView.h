//
//  QFBNavBarView.h
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(BOOL);

@interface QFBNavBarView : UIView

@property (nonatomic, strong) block blockShare;

+ (instancetype)initWithFrame:(CGRect)frame;

@end
