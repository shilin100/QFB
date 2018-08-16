//
//  QFBHomeFunctionButtonView.h
//  QFB
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBHomeViewModel.h"
#import "QFBHomeModel.h"

@interface QFBHomeFunctionButtonView : UICollectionView

@property(nonatomic,strong)NSArray   *dataArray;

@property(nonatomic,strong)QFBHomeViewModel * viewModel;

@end
