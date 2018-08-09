//
//  QFBTool.m
//  QFB
//
//  Created by qqq on 2018/8/6.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBTool.h"
#import "TabbarItemAttributesModel.h"
#import "UICKeyChainStore.h"

@implementation QFBTool

+(NSString *) getUUID {
    
    NSString * bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:bundleIdentifier];
    NSString * uuid;
    if ([keychain stringForKey:@"imeiKeyChain"] != nil) {
        uuid = [keychain stringForKey:@"imeiKeyChain"];
    }else {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ;
        keychain[@"imeiKeyChain"] = uuid;
    }
    
    return uuid;
}


+(NSString *)getClassNameFromModule:(NSString *)module{
    NSDictionary* moduleToClassName = [QFBTool getAllModuleClassNameDictionary];
    if (moduleToClassName[module] == nil) {
        CXLog(@"模块名与参数名不符");
        return nil;
    }
    return moduleToClassName[module];
}

+(NSDictionary * )getAllModuleClassNameDictionary{
    return @{
             @"首页":@"QFBHomeViewController",
             @"盟友":@"QFBAllianceViewController",
             @"收益":@"QFBEarningViewController",
             @"我的":@"QFBMineViewController"
             };
}

+(NSArray*)getDefaultModules{
    return @[@"首页",@"盟友",@"收益",@"我的"];
}

+(NSDictionary*)getAllTabbarItemAttributes{
    return @{
             @"首页":[TabbarItemAttributesModel AttributesToolTitle:@"首页" imageName:@"tabbar_check_nor" selectedImageName:@"tabbar_check_sel"],
             @"盟友":[TabbarItemAttributesModel AttributesToolTitle:@"盟友" imageName:@"tabbar_history_nor" selectedImageName:@"tabbar_history_sel"],
             @"收益":[TabbarItemAttributesModel AttributesToolTitle:@"收益" imageName:@"tabbar_report_nor" selectedImageName:@"tabbar_report_sel"],
             @"我的":[TabbarItemAttributesModel AttributesToolTitle:@"我的" imageName:@"tabbar_function_nor" selectedImageName:@"tabbar_function_sel"]
             };;
}


@end
