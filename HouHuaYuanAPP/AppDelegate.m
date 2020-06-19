//
//  AppDelegate.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UserNotifications/UserNotifications.h>
#import <WXApi.h>
#import "TabBarController.h"
#import "LYGuideViewController.h"
#import <JKRBDMuteSwitch/RBDMuteSwitch.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FangZhiCrachVC.h"
#import "Crash.h"

#define UMKey @"5d4d1fc90cafb2e93d00066c"
//友盟安全密钥//ejgdywphxmg48nejku6jbusvxwigb8rv
#define SinaAppKey @"3605220977"
#define SinaAppSecret @"21538c5bda3ff74eed852ed4baf250f3"
#define WXAppID @"wxa9d5e96c3c7560c5"
#define WXAppSecret @"831141212f70062d7cab39b2571cfb7e"
#define QQAppID @"1109767681"
#define QQAppKey @"K299TMqRouNznqcl"


@interface AppDelegate ()<EMChatManagerDelegate,RBDMuteSwitchDelegate,UNUserNotificationCenterDelegate,WXApiDelegate>
@property(nonatomic,assign)BOOL isJingYin;
@property(nonatomic,assign)CGFloat yinLiang;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self instantiateRootVC];
    [self.window makeKeyAndVisible];
    //    self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKey];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    [self initUment:launchOptions];
    
    // 发送崩溃日志
    
    //注册消息处理函数的处理方法
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    // 发送崩溃日志
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [path stringByAppendingPathComponent:@"error.log"];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    NSString *content=[NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"\n\n\n---%@",content);
    
    
    if (data != nil) {
        
        [self.window.rootViewController presentViewController:[[FangZhiCrachVC alloc] init] animated:YES completion:nil];
        
    }
    
    [self updateNewAppWith:ppppppid];
    
    
    //    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //
    //    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    //
    //    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    //
    //    if (data != nil) {
    //
    //         [self.window.rootViewController presentViewController:[[FangZhiCrachVC alloc] init] animated:YES completion:nil];
    //
    //    }
    
    if ([YWUnlockView haveGesturePassword]) {
        [self privacyPassWord];
    }
    
    EMOptions *options = [EMOptions optionsWithAppkey:huanXinAppKey];
    // apnsCertName是证书名称，可以先传nil，等后期配置apns推送时在传入证书名称
    options.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //上包位置
    [HHYpublicFunction updateLatitudeAndLongitude];
    
    [[EMClient sharedClient].chatManager addDelegate:self  delegateQueue:nil];;
    
    //    //是否静音
    [[RBDMuteSwitch sharedInstance] setDelegate:self];
    [[RBDMuteSwitch sharedInstance] detectMuteSwitch];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    self.yinLiang = audioSession.outputVolume;
    
    [MPVolumeView new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemVolumeDidChangeNoti:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    return YES;
}

-(void)systemVolumeDidChangeNoti:(NSNotification* )noti{//目前手机音量
    float voiceSize = [[noti.userInfo valueForKey:@"AVSystemController_AudioVolumeNotificationParameter"]floatValue];
    NSLog(@"\n===========----%lf",voiceSize);
    self.yinLiang = voiceSize;
    
}


//收到环信消息时发送通知去刷新通知和校信的信息
- (void)messagesDidReceive:(NSArray *)aMessages {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat currentVol = audioSession.outputVolume;
    
    NSLog(@"\n----%lf",currentVol);
    
    if (self.yinLiang == 0) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }else {
        AudioServicesPlaySystemSound(1012);
    }
    
    
    TabBarController * tabvc = self.window.rootViewController;
    if (tabvc.selectedIndex == 2) {
        BaseNavigationController * navc = tabvc.childViewControllers[2];
        if ([[navc.childViewControllers lastObject] isKindOfClass:[HangQingVC class]]) {
            HangQingVC * vc = (HangQingVC *)[navc.childViewControllers lastObject];
            vc.pageNo = 1;
            [vc loadFromServeTTTT];
        }
    }
    
    
    //
    ////
    //     AudioServicesPlaySystemSound(1007);
    //    return;
    
    
}



- (void)privacyPassWord {
    
    YWUnlockView * v = [YWUnlockView shareInstace];
    v.type = YWUnlockViewUnlock;
    __weak typeof(self) weakSelf = self;
    v.block = ^(BOOL result) {
        NSLog(@"-->%@",@(result));
        
        
        
    };
    v.forgetPassBlock = ^(NSInteger type) {
        NSLog(@"-->%@",@(type));
        
        if(type == 1) {
            
            
            [self outLogin];
            
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
}

//退出登录
- (void)outLogin {
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getlogoutURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            [HHYSignleTool shareTool].isLogin = NO;
            TabBarController * tavc = (TabBarController *)self.window.rootViewController;
            tavc.selectedIndex = 0;
            [[EMClient sharedClient] logout:YES];
            [YWUnlockView deleteGesturesPassword];
            
        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

- (void)initUment:(NSDictionary *)launchOptions{
    //友盟适配https
    [UMessage startWithAppkey:UMKey launchOptions:launchOptions httpsEnable:YES];
    //    [UMessage startWithAppkey:UMKey launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
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
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
                            
                            [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
                            [alert addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",strOfAppid]]];
                                exit(0);
                                
                            }]];
                            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                        });
                        
                    }else {
                        [SVProgressHUD showSuccessWithStatus:@"目前安装的已是最新版本"];
                    }
                    
                    
                }
            }
        }
    }] resume];
    
    
}



- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dataDict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dataDict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}


//在用户接受推送通知后系统会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.pushToken = deviceToken;
    
    [UMessage registerDeviceToken:deviceToken];
    //2.获取到deviceToken
    NSString *token = @"";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
           if (![deviceToken isKindOfClass:[NSData class]]) {
               //记录获取token失败的描述
               return;
           }
           const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
           token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                    ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                    ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                    ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
           NSLog(@"deviceToken1:%@", token);
       } else {
           token = [NSString
                    stringWithFormat:@"%@",deviceToken];
           token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
           token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
           token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
           
       }
    //将deviceToken给后台
    NSLog(@"send_token:%@",token);
    [HHYSignleTool shareTool].deviceToken = token;
    [[HHYSignleTool shareTool] uploadDeviceToken];
    
}


//设置根视图控制器
- (UIViewController *)instantiateRootVC{
    
    //没有引导页
    TabBarController *BarVC=[[TabBarController alloc] init];
    return BarVC;
    //    //获取app运行的版本号
    //    NSString *currentVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //    //取出本地缓存的版本号
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *localVersion = [defaults objectForKey:@"appversion"];
    //    if ([currentVersion isEqualToString:localVersion]) {
    //        TabBarController *BarVC=[[TabBarController alloc] init];
    //        return BarVC;
    //        //        TabBarController * tabVc = [[TabBarController alloc] init];
    //        //        return tabVc;
    //
    //    }else{
    //        LYGuideViewController *guideVc = [[LYGuideViewController alloc] init];
    //        return guideVc;
    //    }
}
//跳转主页
- (void)showHomeVC{
    TabBarController  *BarVC=[[TabBarController alloc] init];
    self.window.rootViewController = BarVC;
    //更新本地储存的版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appversion"];
    //同步到物理文件存储
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -支付宝 微信支付
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxa9d5e96c3c7560c5://pay"] ) {
        //微信
        [WXApi handleOpenURL:url delegate:self];
        
    }else {//友盟
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知,告诉支付界面要做什么
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxa9d5e96c3c7560c5://pay"] ) {
        
        [WXApi handleOpenURL:url delegate:self];
        
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    //跳转到支付宝支付的情况
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBPAY" object:resultDic];
            
            NSLog(@"result ======================== %@",resultDic);
        }];
    } else if ([url.absoluteString hasPrefix:@"wxa9d5e96c3c7560c5://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return YES;
}
//微信支付结果
- (void)onResp:(BaseResp *)resp {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPAY" object:resp];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
