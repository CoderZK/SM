//
//  TabBarController.m
//  Elem1
//
//  Created by sny on 15/9/17.
//  Copyright (c) 2015年 cznuowang. All rights reserved.
//

#import "TabBarController.h"
#import "BaseViewController.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "HangQingVC.h"
#import "GuanZhuVC.h"
#import "BSCustom.h"
@interface TabBarController ()
{
    BaseNavigationController * _mineNavi;
    UIButton * button;
    NSTimer *timer;
}
@end

@implementation TabBarController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    NSArray *imgArr=@[@"homeicon_1",@"friends_1",@"homeNews_1",@"mine_1"];
    NSArray *selectedImgArr=@[@"homeicon",@"friends",@"homeNews",@"mine"];
    NSArray *barTitleArr=@[@"社区",@"交友",@"消息",@"我"];
    NSArray *className=@[@"HomeVC",@"GuanZhuVC",@"HangQingVC",@"MineVC"];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    for (int i=0; i<className.count; i++)
    {
        NSString *str=[className objectAtIndex:i];
        BaseViewController *vc = nil;
        
        //此处创建控制器要根据自己的情况确定是否带tableView 
        
        if (i== 1)
        {
           vc=[[NSClassFromString(str) alloc] init];
        }
        else
        {
            vc=[[NSClassFromString(str) alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        }
    

        NSString *str1=[imgArr objectAtIndex:i];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attrs[NSForegroundColorAttributeName] = CharacterBlackColor;
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = TabberGreen;
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        //让图片保持原来的模样，未选中的图片
        vc.tabBarItem.image=[[UIImage imageNamed:str1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //图片选中时的图片
        NSString *str2=[selectedImgArr objectAtIndex:i];
        vc.tabBarItem.selectedImage=[[UIImage imageNamed:str2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //页面的bar上面的title值
        NSString *str3=[barTitleArr objectAtIndex:i];
        vc.tabBarItem.title=str3;
        self.tabBar.tintColor=[UIColor blackColor];
        
        //给每个页面添加导航栏
        BaseNavigationController *nav=[[BaseNavigationController alloc] initWithRootViewController:vc];
        [arr addObject:nav];
    }
   [self setValue:[[BSCustom alloc] init] forKey:@"tabBar"];
    self.viewControllers=arr;
    _mineNavi = arr.lastObject;
    self.tabBar.barTintColor = [UIColor whiteColor];
        
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(redRefresh) userInfo:nil repeats:YES];
    
     [[NSRunLoop currentRunLoop] addTimer: timer  forMode:NSRunLoopCommonModes];
  
    
}

- (void)redRefresh {
    for (int i = 0 ; i < self.childViewControllers.count; i++) {
        BaseNavigationController * navc = (BaseNavigationController *)self.childViewControllers[i];
        if (navc.childViewControllers.count > 1) {
            return;
        }
    }
    
    [self loadFromServeTTTT];
    
    
    
}

- (void)loadFromServeTTTT {
    
    if ([HHYSignleTool shareTool].isLogin ==NO) {
        return;
    }
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"pageNo"] = @(1);
    dataDict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[HHYURLDefineTool getMyMessageListURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
    
        if ([responseObject[@"code"] intValue]== 0) {

            HHYTongYongModel * model = [HHYTongYongModel mj_objectWithKeyValues:responseObject[@"object"]];
            
            if ([model.AtMsg intValue] + [model.FriendMsg intValue] + [model.LikeMsg intValue] + [model.sysMsg intValue] + [model.ReplyMsg intValue] == 0 ) {
                [self.tabBar.items[2] hidenBadge];
            }else {
                [self.tabBar.items[2] showBadge];
            }
            
            BaseNavigationController * bnavc = (BaseNavigationController *)self.viewControllers[2];
            if (bnavc != nil) {
                HangQingVC * vc = (HangQingVC *)[bnavc.childViewControllers firstObject];
                vc.model = model;
                [vc.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
            }
            
            
            
            

        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}





@end
