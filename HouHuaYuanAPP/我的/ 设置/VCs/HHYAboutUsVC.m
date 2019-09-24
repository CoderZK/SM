//
//  HHYAboutUsVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYAboutUsVC.h"

@interface HHYAboutUsVC ()
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@end

@implementation HHYAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.contentLB.text = @"账户、支付出现问题，或有任何意见，可点击反馈菜单进行反馈; \n也可使用如下方式联系我们 我的->设置->意见反馈->联系在线客服";
    
    [self loadFromServeTTTT];
    
}

- (void)loadFromServeTTTT {
 
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getBannerListURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
 
        if ([responseObject[@"code"] intValue]== 0) {
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
  
        
        
    }];
    
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
