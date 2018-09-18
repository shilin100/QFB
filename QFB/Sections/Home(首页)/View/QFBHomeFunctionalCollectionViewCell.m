//
//  QFBHomeFunctionalCollectionViewCell.m
//  QFB
//
//  Created by apple on 2018/8/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeFunctionalCollectionViewCell.h"

@implementation QFBHomeFunctionalCollectionViewCell

+ (instancetype) QFBHomeFunctionalCollectionViewCell:(UICollectionView *)collectionView WithIndexpath:(NSIndexPath *)indexpath
{
    static  NSString *const idengtifier = @"QFBHomeFunctionalCollectionViewCell";
    QFBHomeFunctionalCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:idengtifier forIndexPath:indexpath];
    
    return item;
}

@end
