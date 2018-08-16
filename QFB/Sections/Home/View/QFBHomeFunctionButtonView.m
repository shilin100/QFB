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
    QFBHomeFunctionalCollectionViewCell *cell = [QFBHomeFunctionalCollectionViewCell QFBHomeFunctionalCollectionViewCell:collectionView WithIndexpath:indexPath];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@""]];
    cell.valueLab.text = model.value;
    NSLog(@"%@",model.value);
    return cell;
}
@end
