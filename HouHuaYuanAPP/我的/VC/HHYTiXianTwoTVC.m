//
//  HHYTiXianTwoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYTiXianTwoTVC.h"
#import "HHYTiXianJiLuTVC.h"
#import "HHYYinHangKaTVC.h"
@interface HHYTiXianTwoTVC ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *carTF;
@property (weak, nonatomic) IBOutlet UIButton *tixianBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property(nonatomic,strong)NSString *carNumber;

@end

@implementation HHYTiXianTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    
    self.tixianBt.layer.cornerRadius = 22;
    self.tixianBt.clipsToBounds = YES;
    
//    UIButton * hitClickButtonn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
//    
//    //    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
//    [hitClickButtonn setTitle:@"提现记录" forState:UIControlStateNormal];
//    hitClickButtonn.titleLabel.font = kFont(14);
//    [hitClickButtonn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [hitClickButtonn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    hitClickButtonn.tag = 11;
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hitClickButtonn];
    
     self.titleLB.text = [NSString stringWithFormat:@"可提现%0.2f元(1元对应10个鲜花)",[self.flowerNumber floatValue]];
    
    
}

- (void)navigationItemButtonAction:(UIButton *)button {
    HHYTiXianJiLuTVC * vc =[[HHYTiXianJiLuTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)action:(UIButton *)button {
    if (button.tag == 100) {
        
        HHYYinHangKaTVC * vc =[[HHYYinHangKaTVC alloc] init];
        Weak(weakSelf);
        vc.sendCarBlock = ^(HHYTongYongModel * _Nonnull model) {
            
            NSString * str = model.cardNo;
            if (model.cardNo.length > 4) {
                str = [model.cardNo substringWithRange:NSMakeRange(model.cardNo.length - 4, 4)];
            }
            weakSelf.carTF.text = [NSString stringWithFormat:@"%@   尾号%@",model.bankName,str];
            
            weakSelf.carNumber = model.cardNo;
            
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(button.tag == 101) {
        //点击全部提现
        self.moneyTF.text = [NSString stringWithFormat:@"%0.2f",[self.flowerNumber floatValue]];
        
    }else {
        //单击确认提现
        if (self.moneyTF.text.length == 0 ){
            [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
            return;
        }
        if ([self.moneyTF.text floatValue]>[self.flowerNumber floatValue]){
            [SVProgressHUD showErrorWithStatus:@"提现金额不足"];
            return;
        }
        if ([self.moneyTF.text floatValue] <0){
            [SVProgressHUD showErrorWithStatus:@"请输入大于0的金额"];
            return;
        }
        
        NSMutableDictionary * dataDict = @{}.mutableCopy;
        dataDict[@"accountType"] = @(1);
        dataDict[@"flowerNum"] = self.moneyTF.text;
        dataDict[@"targetAccount"] = self.carNumber;
        
        [zkRequestTool networkingPOST:[HHYURLDefineTool addWithDrawURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {

            if ([responseObject[@"code"] intValue]== 0) {
                
                [SVProgressHUD showSuccessWithStatus:@"提现操作成功"];
               
                self.titleLB.text = [NSString stringWithFormat:@"可提现%0.2f元",[self.flowerNumber floatValue] - [self.moneyTF.text floatValue]];
                [self.moenySignal sendNext:@([self.moneyTF.text floatValue] *10)];
                [self.moenySignal sendCompleted];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            

            
        }];
        
        
    }
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
