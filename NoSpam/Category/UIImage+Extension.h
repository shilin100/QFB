//
//  UIImage+Extension.h
//  Created by JiangAijun on 14/10/31.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color;

+(UIImage *)stretchedImageWithName:(NSString *)name;

- (instancetype)circleImage;
+ (instancetype)circleImageNamed:(NSString *)name;

@end
