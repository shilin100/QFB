//
//  QFBEarningTypeView.h
//  QFB
//
//  Created by qqq on 2018/8/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBEarningTypeView : UIView
+(QFBEarningTypeView *)initWithColor:(UIColor*)color;
-(void)setTitle:(NSString*)title andPercent:(NSString*)percent;
@end
