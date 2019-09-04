//
//  HHYSettingTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYSettingTVC.h"
#import "HHYTongYongCell.h"
#import "Clear.h"
#import "HHYBindPhoneVC.h"
#import "HHYBindPoneTwoVC.h"
#import "HHYBindQWXVC.h"
#import "HHYChangePasswordVC.h"
#import "HHYPrivacyTVC.h"
#import "HHYAboutUsVC.h"
#import "HHYQuanZiGuiZeListTVC.h"
#import <AudioToolbox/AudioToolbox.h>
@interface HHYSettingTVC ()
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIButton *outLoginBt;
@end

@implementation HHYSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.outLoginBt = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 50, ScreenW, 50)];
    [self.outLoginBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [self.outLoginBt setTitle:@"退出登录" forState:UIControlStateNormal];
    self.outLoginBt.titleLabel.font = kFont(15);
    [self.outLoginBt addTarget:self action:@selector(outLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.outLoginBt];
    
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH  - 50);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH  - 50 - 34);
        self.outLoginBt.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 50 - 34 , ScreenW, 50);
    }
    
    [self.tableView registerClass:[HHYTongYongCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.arr = @[@[@"绑定手机号",@"更换绑定手机号",@"绑定第三方",@"更换密码"],@[@"查看圈子规则",@"隐私设置",@"清理缓存",@"分享APP",@"关于我们",@"检测新版本"]];
    
}

- (void)outLogin {
        
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getlogoutURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            [zkSignleTool shareTool].isLogin = NO;
            self.tabBarController.selectedIndex = 0;
            [[EMClient sharedClient] logout:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 0.01;
    }else {
        return 10;
    }
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHYTongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.lineV.hidden = YES;
    cell.clipsToBounds = YES;
    cell.leftLB.text = self.arr[indexPath.section][indexPath.row];
    cell.lineV.hidden = YES;
    cell.TF.hidden = YES;
    cell.swith.hidden = YES;
    if (indexPath.row + 1 == [self.arr[indexPath.section] count]) {
        cell.lineV.hidden = YES;
    }else {
        cell.lineV.hidden = NO;
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        cell.TF.hidden = NO;
        
        cell.TF.text = [NSString stringWithFormat:@"%0.1fM",[Clear folderSizeAtPath]];
        
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            if (self.phoneStr.length > 0) {
                [SVProgressHUD showErrorWithStatus:@"您已经绑定手机号了!"];
                return;
            }
            
            HHYBindPhoneVC * vc =[[HHYBindPhoneVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isBangDing = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            if (self.phoneStr.length <11) {
                [SVProgressHUD showErrorWithStatus:@"您还没有绑定手机号!"];
                return;
            }
            HHYBindPoneTwoVC * vc =[[HHYBindPoneTwoVC alloc] init];
            vc.phoneStr = self.phoneStr;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            HHYBindQWXVC * vc =[[HHYBindQWXVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
            HHYChangePasswordVC * vc =[[HHYChangePasswordVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.phoneStr = self.phoneStr;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HHYQuanZiGuiZeListTVC * vc =[[HHYQuanZiGuiZeListTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            HHYPrivacyTVC * vc =[[HHYPrivacyTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            [Clear cleanCache:^{
                
                [tableView reloadData];
                
            }];
        }else if (indexPath.row == 3) {
            
           [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:[zkSignleTool shareTool].huanxin shareModel:nil];
            
        }else if (indexPath.row == 4) {
            HHYAboutUsVC * vc =[[HHYAboutUsVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 5) {
            //版本检测
            [self updateNewAppWith:@"1008521774"];
        }
    }else if (indexPath.section == 2) {
        
        
    }
    
    
    if (indexPath.section == 1 && indexPath.row == 2) {
       
        
    }
}




- (void)updateNewAppWith:(NSString *)strOfAppid {
    
    
    [SVProgressHUD show];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",strOfAppid]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              [SVProgressHUD dismiss];
                                             if (data)
                                             {
                                                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                 
                                                 if (dic)
                                                 {
                                                     NSArray * arr = [dic objectForKey:@"results"];
                                                     if (arr.count>0)
                                                     {
                                                         NSDictionary * versionDict = arr.firstObject;
                                                         
                                                         NSString * version = [[versionDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                         NSString * currentVersion = [[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                         
                                                         if ([version integerValue]>[currentVersion integerValue])
                                                         {
                                                           
                                                             
                                                             UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                           
                                                             [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
                                                             [alert addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",strOfAppid]]];
                                                                 exit(0);
                                                                 
                                                             }]];
                                                             [self presentViewController:alert animated:YES completion:nil];
                                                         }else {
                                                             [SVProgressHUD showSuccessWithStatus:@"目前安装的已是最新版本"];
                                                         }
                                                         
                                                         
                                                     }
                                                 }
                                             }
                                         }] resume];
        

}


@end
