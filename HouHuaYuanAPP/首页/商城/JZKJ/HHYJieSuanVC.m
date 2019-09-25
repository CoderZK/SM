//
//  HHYJieSuanVC.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/19.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "HHYJieSuanVC.h"
#import "HHYAddressTVC.h"

@interface HHYJieSuanVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;

@end

@implementation HHYJieSuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"结算";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)pay:(UIButton *)sender {
    
    if (self.titleLB.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    
    UIAlertController * vc =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"如果您在购物过程出现任何问题,都可以去 我的->意见反馈->联系客服" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (sender.tag == 100) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
            }else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipay://"]];
            }
        });
    }];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

    }];
    [vc addAction:action];
    [vc addAction:action1];
    [self presentViewController:vc  animated:YES completion:nil];
}

- (IBAction)conAction:(id)sender {
    if (self.titleLB.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
        return;
    }
    
    UIAlertController * vc =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"本app暂时未开通线上支付功能,您提交订单成功后,我们会有专门会联系你,感谢您的使用" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定购买" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSString * str = @"";
        for (int i = 0 ; i < self.itemArr.count; i++) {
            if (i == 0) {
                str =  [NSString stringWithFormat:@"(ID = %ld and goodId = '%@')",self.itemArr[i].ID,self.itemArr[i].goodId];
                
            }else {
               str = [str stringByAppendingString: [NSString stringWithFormat:@" or (ID = %ld and goodId ='%@')",self.itemArr[i].ID,self.itemArr[i].goodId]];
            }
        }
        
        
        
        
//        NSString * sql =  [NSString stringWithFormat:@"delete from HHY_mygoodscar where %@",str];
        NSString * sql =  [NSString stringWithFormat:@"update HHY_mygoodscar set status = 1 where %@",str];
        
        FMDatabase * db =[FMDBSingle shareFMDB].fd;
        if ([db open]) {
           BOOL delete = [db executeUpdate:sql ];
            if (delete) {
                [SVProgressHUD showSuccessWithStatus:@"订单提交成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else {
                 NSLog(@"%@",@"失败");
            }
            
        }
        [db close];
        
    }];
    [vc addAction:action];
    [self presentViewController:vc  animated:YES completion:nil];
    
    
}

- (IBAction)addressaction:(id)sender {
    
  
    
    HHYAddressTVC * vc =[[HHYAddressTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    typeof(self) weakSelf = self;
    vc.sendAddressBlock = ^(HHYHomeModel * _Nonnull model) {
        weakSelf.titleLB.text =  [NSString stringWithFormat:@"姓名:%@  %@,",model.name,model.phone];
        weakSelf.addressLB.text =  [NSString stringWithFormat:@"%@",model.address];
    };
    [self.navigationController pushViewController:vc  animated:YES];
    
}


@end
