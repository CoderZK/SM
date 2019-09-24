//
//  UIViewController+NewWorkTwo.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "UIViewController+NewWorkTwo.h"



@implementation UIViewController (NewWorkTwo)

- (void)deleteMessageWithMessageId:(NSString *)ID result:(void(^)(BOOL isOK))deleteBlock{
    

    
    [zkRequestTool networkingPOST:[HHYURLDefineTool deleteMegURL] parameters:ID success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            deleteBlock(YES);
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
    
    
}

- (void)gotoCharWithOtherHuanXinID:(NSString *)huanxin andOtherUserId:(NSString *)userId andOtherNickName:(NSString *)nickName andOtherImg:(NSString *)img andVC:(BaseViewController *)baseVc{
    
    if ([userId isEqualToString:[HHYSignleTool shareTool].session_uid]) {
        [SVProgressHUD showErrorWithStatus:@"自己不能喝自己聊天"];
        return;
    }
    
    zkDanLiaoVC * vc = [[zkDanLiaoVC alloc] initWithConversationChatter:huanxin conversationType: EMConversationTypeChat];
    vc.otherId = userId;
    vc.otherName = nickName;
    vc.otherHuanXinId = huanxin;
    vc.otherHeadImg = [HHYURLDefineTool getImgURLWithStr:img];
    vc.myName = [HHYSignleTool shareTool].nickName;
    vc.myHeadImg = [HHYSignleTool shareTool].img;
    vc.myHuanXinId = [HHYSignleTool shareTool].huanxin;
    vc.hidesBottomBarWhenPushed = YES;
    [baseVc.navigationController pushViewController:vc animated:YES];
    
}


- (void)sendFlowerWithNumber:(NSString *)number andLinkId:(NSString *)ID andIsGiveUser:(BOOL)isGeiUser result:(void(^)(BOOL isOK))resultBlock {
    
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"flowerNum"] = @([number integerValue]);
    dataDict[@"linkId"] = ID;
    if (isGeiUser) {
        dataDict[@"type"] = @"userInfo";
    }else {
        dataDict[@"type"] = @"postInfo";
    }
    [zkRequestTool networkingPOST:[HHYURLDefineTool sendFlowers] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 0) {
            
            resultBlock(YES);
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
    
}


@end
