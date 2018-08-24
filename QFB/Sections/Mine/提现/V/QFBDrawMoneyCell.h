//
//  QFBDrawMoneyCell.h
//  QFB
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBDrawMoneyCellModel.h"

@interface QFBDrawMoneyCell : UICollectionViewCell

+ (instancetype) initWithCollectionView:(UICollectionView *)cv indexPath:(NSIndexPath *)path model:(QFBDrawMoneyCellModel *)model;

@end
