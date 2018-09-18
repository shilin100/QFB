//
//  QFBBaseNavViewController.h
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBBaseNetWorkController : UIViewController

@property (nonatomic, strong) QFBNetWorkTool *netWorkTool;

- (void)showNoDataViewWithTitle:(NSString *)title view:(UIView *)view;
- (void)removeNoDataView;

@end
