//
//  PNPieChart+InnerRadius80Percent.m
//  QFB
//
//  Created by qqq on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "PNPieChart+InnerRadius80Percent.h"

@implementation PNPieChart (InnerRadius80Percent)

-(void)recompute{
    
    CGFloat minimal = (CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds)) ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    self.outerCircleRadius = minimal / 2;
    self.innerCircleRadius = minimal / 2 * 0.85;
    
}

@end
