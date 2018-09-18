//
//  QFBBaseViewController.h
//  QFB
//
//  Created by qqq on 2018/9/7.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBBaseViewController : UIViewController

@property (nonatomic, strong) QFBNetWorkTool *network;
@property (nonatomic, strong) UITableView *tableView;

- (void)showLoading;

- (void)dismissLoading;

- (void)loadMore:(BOOL)isMore;

- (void)createHeaderRefreshing;

- (void)createFooterRefreshing;

// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;

@end
