//
//  QFBEarningTableView.h
//  QFB
//
//  Created by qqq on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBEarningViewModel.h"

@interface QFBEarningTableView : UITableView
@property(nonatomic,strong)NSMutableArray   *dataArray;

@property(nonatomic,strong)QFBEarningViewModel *viewModel;

@end
