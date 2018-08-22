//
//  NSTimer+addition.m
//  DJYQM
//
//  Created by BoFeng on 2017/9/21.
//  Copyright © 2017年 BoFeng. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

- (void)pauseTime {
    
    if (!self.isValid) return;     //  BOOL valid 获取定时器是否有效
    [self setFireDate:[NSDate distantFuture]];  //停止定时器
    
}

- (void)webPageTime {
    
    if (!self.isValid) return;   // date方法返回的就是当前时间(now)
    [self setFireDate:[NSDate date]];
}

- (void)webPageTimeWithTimeInterval:(NSTimeInterval)time  {
    
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];   //返回当前时间10秒后的时间
}

@end
