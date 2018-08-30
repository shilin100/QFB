//
//  QFBDrawMoneyCollectionView.h
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBDrawMoneyListModel.h"

@interface QFBDrawMoneyCollectionView : UICollectionView

- (void)loadDrawMoneyListModel:(QFBDrawMoneyListModel *)model;

- (double)getCanDrawMoney;  // 获取可以提现的金额
- (int)getCurrentIndex;     // 获取当前是第几个cell

@end
