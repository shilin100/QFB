//
//  TabbarModulesModel.m
//  ZhiFa
//
//  Created by Exsun on 16/8/9.
//  Copyright © 2016年 wei. All rights reserved.
//

#import "TabbarItemAttributesModel.h"
@implementation TabbarItemAttributesModel

+(TabbarItemAttributesModel *)AttributesToolTitle: (NSString*) title
                              imageName :(NSString*) imageName
                      selectedImageName :(NSString*) selectedImageName{
    TabbarItemAttributesModel* attributes = [[TabbarItemAttributesModel alloc]init];
    attributes.title = title;
    attributes.imageName = imageName;
    attributes.selectedImageName = selectedImageName;
    return attributes;
}


@end
