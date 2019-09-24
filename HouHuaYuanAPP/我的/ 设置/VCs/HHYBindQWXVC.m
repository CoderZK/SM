//
//  HHYBindQWXVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYBindQWXVC.h"

@interface HHYBindQWXVC ()

@end

@implementation HHYBindQWXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定第三方";
}
- (IBAction)action:(UIButton *)button {
    
    if (button.tag == 100) {
        //QQ
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
    }else if (button.tag == 101) {
        //wx
        [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
    }else if (button.tag == 102) {
        //WB
        [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
    }
    
    
}


- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        //        NSLog(@" uid: %@", resp.uid);
        //        NSLog(@" openid: %@", resp.openid);
        //        NSLog(@" accessToken: %@", resp.accessToken);
        //        NSLog(@" refreshToken: %@", resp.refreshToken);
        //        NSLog(@" expiration: %@", resp.expiration);
        //        // 用户数据
        //        NSLog(@" name: %@", resp.name);
        //        NSLog(@" iconurl: %@", resp.iconurl);
        //        NSLog(@" gender: %@", resp.unionGender);
        //        // 第三方平台SDK原始数据
        //        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        [self logWithUMSocialUserInfoResponse:resp];
        
        
    }];
}

//绑定第三方
- (void)logWithUMSocialUserInfoResponse:(UMSocialUserInfoResponse *)resp {
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"appkey"] = resp.openid;
    if (resp.platformType == UMSocialPlatformType_WechatSession) {
        dataDict[@"type"] = @"wechat";
    }else if (resp.platformType == UMSocialPlatformType_Sina) {
        dataDict[@"type"] = @"xinlang";
    }else if (resp.platformType == UMSocialPlatformType_QQ) {
        dataDict[@"type"] = @"qq";
    }
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool updateThirdAppURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            if ([responseObject[@"code"] intValue]== 0) {
                [SVProgressHUD showSuccessWithStatus:@"绑定第三方成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
}


@end
