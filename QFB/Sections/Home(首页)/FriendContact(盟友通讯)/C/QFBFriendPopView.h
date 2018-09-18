//
//  QFBFriendPopView.h
//  QFB
//
//  Created by qqq on 2018/9/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockObject)(id obj);

@interface QFBFriendPopView : UIView

@property (nonatomic, strong) blockObject block;

- (instancetype)initWithFrame:(CGRect)frame roles:(NSMutableArray<QFBRoleModel *> *)roleArray;

@end
