//
//  QFBDistributionFootView.h
//  QFB
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockPress)(BOOL isClick);

@interface QFBDistributionFootView : UIView

@property (nonatomic, strong) blockPress block;

+ (instancetype)initWithFrame:(CGRect)frame;


@end
