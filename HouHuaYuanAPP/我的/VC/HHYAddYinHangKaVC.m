//
//  HHYAddYinHangKaVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYAddYinHangKaVC.h"

@interface HHYAddYinHangKaVC ()
@property (weak, nonatomic) IBOutlet UIButton *tixianBt;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phuneTF;
@property (weak, nonatomic) IBOutlet UITextField *carTypeTF;
@property (weak, nonatomic) IBOutlet UITextField *carNumberTF;

@end

@implementation HHYAddYinHangKaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    self.tixianBt.layer.cornerRadius = 22;
    self.tixianBt.clipsToBounds = YES;
}


- (IBAction)add:(id)sender {
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    if (self.phuneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入银行预留手机号"];
        return;
    }
    if (self.carTypeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入开户行"];
        return;
    }
    if (self.carNumberTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入银行卡号"];
        return;
    }
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"bankName"] = self.carTypeTF.text;
    dict[@"cardNo"] = self.carNumberTF.text;
    dict[@"phone"] = self.phuneTF.text;
    dict[@"realName"] = self.nameTF.text;
    
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool addMyBankCardURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加银行卡成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
 
        
    }];
    
    

}




@end
