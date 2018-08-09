//
//  QFBTool.h
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBTool : NSObject

+(NSString *) getUUID;

//模块对应类名
+(NSString*)getClassNameFromModule:(NSString*)module;
//所有模块对应类名
+(NSDictionary*)getAllModuleClassNameDictionary;

+(NSArray*)getDefaultModules;
+(NSDictionary*)getAllTabbarItemAttributes;

@end
