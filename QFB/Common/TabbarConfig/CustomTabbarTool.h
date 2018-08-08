//
//  CustomTabbarTool.h
//  ZhiFa
//
//  Created by Exsun on 16/8/10.
//  Copyright © 2016年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTabbarTool : NSObject

//获取tabbaritem样式
-(NSArray *)getTabbarItemAttributesByModules:( NSArray *)modules;
//获取tabbaritem对应控制器
-(NSArray *)getTabbarControllersByModules:(NSArray *)modules;



@end
