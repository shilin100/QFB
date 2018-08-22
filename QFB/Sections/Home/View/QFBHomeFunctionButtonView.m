//
//  QFBHomeFunctionButtonView.m
//  QFB
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBHomeFunctionButtonView.h"
#import "QFBHomeFunctionalCollectionViewCell.h"


 static NSString *QFBHomeFunctionalCollectionViewCellID = @"QFBHomeFunctionalCollectionViewCell";

@interface QFBHomeFunctionButtonView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation QFBHomeFunctionButtonView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        [self configView];
    }
    
    return self;
    
}


-(void)configView{
    
    self.delegate               = self;
    self.dataSource             = self;
    //self.scrollEnabled = NO;
    UINib *nib = [UINib nibWithNibName:QFBHomeFunctionalCollectionViewCellID bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:QFBHomeFunctionalCollectionViewCellID];
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenuModel * model=self.dataArray[indexPath.row];
    if (indexPath.row == 7) {
        QFBHomeFunctionalCollectionViewCell *cell = [QFBHomeFunctionalCollectionViewCell QFBHomeFunctionalCollectionViewCell:collectionView WithIndexpath:indexPath];
        cell.img.hidden = YES;
        cell.valueLab.hidden = YES;
        [cell.moreimg sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@""]];
        return cell;
    }else
    {
        
        QFBHomeFunctionalCollectionViewCell *cell = [QFBHomeFunctionalCollectionViewCell QFBHomeFunctionalCollectionViewCell:collectionView WithIndexpath:indexPath];
        cell.moreimg.hidden = YES;
        [cell.img sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@""]];
        cell.valueLab.text = model.value;
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuModel * model=self.dataArray[indexPath.row];
    [self.viewModel.earningCellCommand execute:model.value];
}
@end
