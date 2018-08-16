//
//  QFBHomeFunctionalCollectionViewCell.h
//  QFB
//
//  Created by apple on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBHomeFunctionalCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *valueLab;


+ (instancetype) QFBHomeFunctionalCollectionViewCell:(UICollectionView *)collectionView WithIndexpath:(NSIndexPath *)indexpath;

@end
