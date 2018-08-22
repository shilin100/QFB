//
//  NSTimer+addition.h
//  DJYQM
//
//  Created by BoFeng on 2017/9/21.
//  Copyright © 2017年 BoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

- (void)pauseTime;    // 暂停时间
- (void)webPageTime;  // 获取内容所在当前时间
- (void)webPageTimeWithTimeInterval:(NSTimeInterval)time;  // 当前时间 time 秒后的时间

@end
