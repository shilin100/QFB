//
//  QFBAllianceTableView.h
//  QFB
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBAllianceViewModel.h"
#import "QFBAllianceModel.h"

@interface QFBAllianceTableView : UITableView

@property(nonatomic,strong)NSMutableArray   *dataArray;

@property(nonatomic,strong)QFBAllianceViewModel * viewModel;

- (void)loadCellModelArray:(NSMutableArray<QFBAllianceModel *> *)array;

@end
