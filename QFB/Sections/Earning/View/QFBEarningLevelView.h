//
//  QFBEarningLevelView.h
//  QFB
//
//  Created by qqq on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBEarningLevelView : UIView

+(QFBEarningLevelView *)initWithLevel:(NSString*)level;
-(void)changeLevel:(NSString*)level;
@end
