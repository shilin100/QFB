//
//  QFBMineTableView.h
//  QFB
//
//  Created by qqq on 2018/8/16.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBMineViewModel.h"

@interface QFBMineTableView : UITableView
@property(nonatomic,strong)NSMutableArray   *dataArray;
@property(nonatomic,strong)QFBMineViewModel   *viewModel;

@end
