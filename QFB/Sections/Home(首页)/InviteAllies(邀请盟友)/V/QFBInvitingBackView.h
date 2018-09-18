//
//  QFBInvitingBackView.h
//  QFB
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBInvitingBackView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)updateImage:(void(^)(NSString *shareImageUrl))imageUrl;

@end
