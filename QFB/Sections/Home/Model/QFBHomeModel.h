//
//  QFBHomeModel.h
//  QFB
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootingModel : NSObject

/** 首页顶部轮播图片模型 */
/** oBrandId */
@property (nonatomic,copy) NSString *oBrandId;
/** 本地图片链接地址 */
@property (nonatomic,copy) NSString *url;


@end

@interface MenuModel : NSObject

@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *url;


@end
