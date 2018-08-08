
#import <Foundation/Foundation.h>

@class CYLTabBarController;

@interface QFBTabbarControllerConfig : NSObject

@property (nonatomic,strong) NSArray * modules;

-(CYLTabBarController *) getTabbarController;

+(CYLTabBarController*)initRootVCWithModules:(NSArray*)modules;

@end
