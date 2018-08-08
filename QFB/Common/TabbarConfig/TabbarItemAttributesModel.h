//
//  TabbarModulesModel.h
//  ZhiFa
//
//  Created by Exsun on 16/8/9.
//  Copyright © 2016年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabbarItemAttributesModel : NSObject

@property (nonatomic,strong)  NSString* title;
@property (nonatomic,strong)  NSString* imageName;
@property (nonatomic,strong)  NSString* selectedImageName;

+(TabbarItemAttributesModel *)AttributesToolTitle: (NSString*) title
                              imageName :(NSString*) imageName
                      selectedImageName :(NSString*) selectedImageName;
@end
