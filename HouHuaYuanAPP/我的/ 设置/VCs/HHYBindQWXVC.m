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
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"appkey"] = resp.openid;
    if (resp.platformType == UMSocialPlatformType_WechatSession) {
        dict[@"type"] = @"wechat";
    }else if (resp.platformType == UMSocialPlatformType_Sina) {
        dict[@"type"] = @"xinlang";
    }else if (resp.platformType == UMSocialPlatformType_QQ) {
        dict[@"type"] = @"qq";
    }
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool updateThirdAppURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            //            [zkSignleTool shareTool].isLogin = YES;
            //            [zkSignleTool shareTool].session_token = responseObject[@"object"][@"token"];
            //            [zkSignleTool shareTool].session_uid = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"userId"]];
            //            [zkSignleTool shareTool].img =[NSString stringWithFormat:@"%@",responseObject[@"object"][@"avatar"]];
            //            [zkSignleTool shareTool].nickName =[NSString stringWithFormat:@"%@",responseObject[@"object"][@"nickName"]];
            //            [zkSignleTool shareTool].huanxin =[NSString stringWithFormat:@"%@",responseObject[@"object"][@"huanxin"]];
            //            EMError * error = [[EMClient sharedClient] loginWithUsername:responseObject[@"object"][@"huanxin"] password:huanXinMiMa];
            //            if (!error) {
            //
            //                [[EMClient sharedClient].options setIsAutoLogin:YES]; //设定自动登录
            //                [self dismissViewControllerAnimated:YES completion:nil];
            //                NSLog(@"%@",@"登录成功");
            //
            //            }else {
            //
            //            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
}


@end
