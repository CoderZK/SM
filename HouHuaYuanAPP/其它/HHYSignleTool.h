//
//  HHYSignleTool.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHYUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHYSignleTool : NSObject
+ (HHYSignleTool *)shareTool;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,assign)BOOL isUpdate;
@property(nonatomic,strong)NSString * session_token;
@property(nonatomic,strong)NSString * nickName;
@property(nonatomic,strong)NSString * img;
@property(nonatomic,strong)NSString * huanxin;
@property(nonatomic)double  latitude;
@property(nonatomic)double  longitude;
//用户ID
@property(nonatomic,strong)NSString * session_uid;
@property(nonatomic,strong)NSString * deviceToken;
@property(nonatomic,strong)NSString * downUrl;
@property(nonatomic,strong)HHYUserModel *userModel;

-(void)uploadDeviceToken;
@end

NS_ASSUME_NONNULL_END
