//
//  QFBHomeSectionModel.h
//  QFB
//
//  Created by qqq on 2018/9/8.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBBaseModel.h"
#import "QFBHomeActivityModel.h"
#import "QFBHomeListModel.h"
#import "QFBUserModel.h"
#import "QFBHomeCardModel.h"
#import "QFBHomeUserModel.h"
#import "QFBHomeCellModel.h"
#import "QFBBusinessInfoModel.h"
#import "QFBBusinessDetailsModel.h"
#import "QFBMachineModel.h"
#import "QFBHomeModel.h"
#import "QFBMessageModel.h"

@interface QFBHomeSectionModel : QFBBaseModel

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray *cellArray;

@end


