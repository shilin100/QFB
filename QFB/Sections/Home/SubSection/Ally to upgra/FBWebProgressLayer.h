//
//  FBWebProgressLayer.h
//  DJYQM
//
//  Created by BoFeng on 2017/9/21.
//  Copyright © 2017年 BoFeng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface FBWebProgressLayer : CAShapeLayer
// 开始加载
- (void)startLoad;
// 完成加载
- (void)finishedLoadWithError:(NSError *)error;
// 关闭时间
- (void)closeTimer;
- (void)wkWebViewPathChanged:(CGFloat)estimatedProgress;
@end
