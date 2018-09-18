//
//  QFBHomeCellModel.h
//  QFB
//
//  Created by qqq on 2018/9/10.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"


typedef NS_OPTIONS(NSUInteger, CellType) {
    Cell_profit ,
    Cell_Loop ,
    Cell_List ,
    Cell_Info ,
    Cell_Activity ,
};

@interface QFBHomeCellModel : QFBBaseModel

@property (nonatomic, assign) CellType type;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) id cellModel;

@end

