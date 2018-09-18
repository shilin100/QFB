//
//  QFBActivateMachineController.m
//  QFB
//
//  Created by qqq on 2018/9/11.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBActivateMachineController.h"
#import "QFBActivateTableViewController.h"
#import "QFBQRViewController.h"

@interface QFBActivateMachineController ()<UISearchBarDelegate, LBXScanViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchbar;
@property (nonatomic, strong) NSArray *titleData;
@property (nonatomic, weak) QFBActivateTableViewController *currentView;
@property (nonatomic, weak) QFBQRViewController *QRView;

@end

@implementation QFBActivateMachineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"机器激活";
    self.mySearchbar.delegate = self;
}


/**
 点击二维码
 */
- (IBAction)pressCode:(id)sender {
    QFBQRViewController *vc = [[QFBQRViewController alloc] init];
    vc.delegate = self;
    _QRView = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 二维码扫描结果 LBXScanViewControllerDelegate
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    for (LBXScanResult *res in array) {
        NSLog(@"res.strScanned = %@",res.strScanned);
        if ([self isNum:res.strScanned] && res.strScanned.length < 20) {
            _mySearchbar.text = res.strScanned;
            [_currentView searchPasamString:res.strScanned];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请扫描机器上的二维码"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        [_QRView dismissCV];
    }
}

- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_currentView searchPasamString:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *str = searchBar.text;
    if (str.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入pasam码"];
        [SVProgressHUD dismissWithDelay:1.0];
        return ;
    }
    if ([self.mySearchbar isFirstResponder]) {
        [self.mySearchbar resignFirstResponder];
    }
}


#pragma mark - Datasource & Delegate
//
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info
{
    _mySearchbar.text = @"";
    _currentView = viewController;
//    DLog(@"self.selectIndex = %d",self.selectIndex);
}

//  返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}

// 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            QFBActivateTableViewController *vcClass = [[QFBActivateTableViewController alloc] init];
//            vcClass.title = @"0";
            return vcClass;
            break;
        }
        case 1:     // 未达标
        {
            QFBActivateTableViewController *vcClass = [[QFBActivateTableViewController alloc] init];
            vcClass.title = @"2";
            return vcClass;
            break;
        }
        case 2:     //  未激活
        {
            QFBActivateTableViewController *vcClass = [[QFBActivateTableViewController alloc] init];
            vcClass.title = @"0";
            return vcClass;
            break;
        }
        case 3:     // 已激活
        {
            QFBActivateTableViewController *vcClass = [[QFBActivateTableViewController alloc] init];
            vcClass.title = @"1";
            return vcClass;
            break;
        }
        default:{
            
            UIViewController *vcClass = [UIViewController new];
            vcClass.title = @"4";
            return vcClass;
            
        }
            break;
    }
}

// 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleData[index];
}

//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//    return self.view.mj_w / 6;
//}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(10, SafeAreaTopHeight + 55, self.view.frame.size.width - 20, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat h = SafeAreaTopHeight + 55 + 44;
    return CGRectMake(0, h, self.view.frame.size.width, self.view.frame.size.height - h - (SafeAreaBottomHeight - 49));
}

#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 13;
        self.titleSizeSelected = 15;
        self.titleColorNormal = [UIColor blackColor];
        self.titleColorSelected = [UIColor orangeColor];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = (self.view.mj_w - 20) / self.titleData.count;
    }
    return self;
}

// 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"全部机器", @"未达标", @"未激活",@"已激活"];
    }
    return _titleData;
}

- (void)dealloc
{
    logDealloc;
}

@end









