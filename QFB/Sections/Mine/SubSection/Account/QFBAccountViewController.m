//
//  QFBAccountViewController.m
//  QFB
//
//  Created by qqq on 2018/8/20.
//  Copyright © 2018年 qqq. All rights reserved.
//

#import "QFBAccountViewController.h"
#import "QFBAccountTableViewCell.h"
#import "QFBAccountTextTableViewCell.h"
#import "QFBAccountHeadView.h"
#import "QFBLoginViewController.h"

@interface QFBAccountViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *pickerView;

}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (strong, nonatomic)  NSArray *headArray;

@end

@implementation QFBAccountViewController
static NSString * AccountTableViewCellIdentifier = @"AccountTableViewCellIdentifier";
static NSString * AccountTextTableViewCellIdentifier = @"AccountTextTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号信息";
    self.dataArray = [NSMutableArray arrayWithArray:@[@[@{@"title":@"头像"},@{@"title":@"昵称",@"detail":[kDefault objectForKey:NICK_NAMEk]}],
                                                      @[@{@"title":@"真实姓名",@"detail":[kDefault objectForKey:USER_REALNAMEk]},@{@"title":@"证件号码",@"detail":[kDefault objectForKey:USER_IDCARDk]}],
                                                      @[@{@"title":@"真实姓名",@"detail":[kDefault objectForKey:ALIPAY_NAMEk]},@{@"title":@"支付宝账号",@"detail":[kDefault objectForKey:ALIPAY_ACCOUNTk]}]]];
    
    self.headArray = @[@"个人资料",@"商户信息",@"支付宝账号信息"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAccountTableViewCell" bundle:nil] forCellReuseIdentifier:AccountTableViewCellIdentifier];
    [self.tableview registerNib:[UINib nibWithNibName:@"QFBAccountTextTableViewCell" bundle:nil] forCellReuseIdentifier:AccountTextTableViewCellIdentifier];

//    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    self.tableview.tableFooterView = [UIView new];
//    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (IBAction)logoutBtnAction:(id)sender {
    NSString * username = [kDefault objectForKey:USERNAMEk];
    NSString * psw = [kDefault objectForKey:PASSWORDk];
    BOOL isFirstTouch = [kDefault boolForKey:IS_FIRST_TOUCH];

    NSDictionary * dict = [kDefault dictionaryRepresentation];
    
    for (id key in dict) {
        
        [kDefault removeObjectForKey:key];
        
    }
    
    [kDefault synchronize];
    [kDefault setObject:username forKey:USERNAMEk];
    [kDefault setObject:psw forKey:PASSWORDk];
    [kDefault setBool:isFirstTouch forKey:IS_FIRST_TOUCH];

    QFBLoginViewController *vc = [[QFBLoginViewController alloc] init];
    QFBBaseNaviViewController * loginNav = [[QFBBaseNaviViewController alloc]initWithRootViewController:vc];
    APPLication.keyWindow.rootViewController = loginNav;

}

- (void)showActionSheetView
{
    WEAKSELF;
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf startsystemImageLibrary];
    }];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf startCameraController];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCtrl addAction:action];
    [alertCtrl addAction:actionOne];
    [alertCtrl addAction:cancelAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
#pragma mark - 获取图像
- (void)startsystemImageLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerView = nil;
        pickerView = [[UIImagePickerController alloc] init];
        pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerView.delegate = self;
        pickerView.allowsEditing = YES;
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]){
            [self presentViewController:pickerView animated:YES completion:^{
            }];
        }
    }
}

- (void)startCameraController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerView = nil;
        pickerView = [[UIImagePickerController alloc] init];
        pickerView.delegate = self;
        pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        pickerView.allowsEditing = YES;
        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]){
            [self presentViewController:pickerView animated:YES completion:^{
                [self->pickerView setShowsCameraControls:YES];
            }];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickerImage = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(pickerImage, .5f);
    QFBAccountTableViewCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.icon.image = [UIImage imageWithData:imageData];
    
    [self uploadIcon:imageData];
    [picker dismissViewControllerAnimated:YES completion:nil];//退出照相机视图
}
-(void)uploadIcon:(NSData*)iconData{
    NSString *dataStr = [iconData base64EncodedStringWithOptions:0];

    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [kDefault objectForKey:USER_IDk];
    parameter[@"imgdata"] = dataStr;
    

    [QFBNetTool PostRequestWithUrlString:[NSString stringWithFormat:@"%@/pic/upload.action",BASEURL] withDic:parameter Succeed:^(NSDictionary *responseObject) {
        NSString * status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        if ([status isEqualToString:@"1"]) {
            [kDefault setObject:responseObject[@"data"] forKey:USER_HEAD_IMGk];
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
            [SDImageCache.sharedImageCache clearMemory];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        }

    } andFaild:^(NSError *error) {

    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * temp = self.dataArray[section];
    
    return temp.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QFBAccountTableViewCell * cell;
    NSDictionary * temp = self.dataArray[indexPath.section][indexPath.row];

    if (indexPath.section == 0 && indexPath.row == 0) {
       cell = [tableView dequeueReusableCellWithIdentifier:AccountTableViewCellIdentifier forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:[kDefault objectForKey:USER_HEAD_IMGk]] placeholderImage:[UIImage imageNamed:@"我的默认头像"]];
        cell.mytitile.text = temp[@"title"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }else{
        QFBAccountTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AccountTextTableViewCellIdentifier forIndexPath:indexPath];
        NSString * detail = temp[@"detail"];
        cell.mydetail.text = IS_STR_EMPTY(detail) ? @"尚未实名认证" : detail;
        cell.mytitile.text = temp[@"title"];

        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QFBAccountHeadView * headview = [[QFBAccountHeadView alloc]init];
    headview.titleLabel.text = self.headArray[section];
    return headview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    } else
        return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self showActionSheetView];
    }
}













@end
