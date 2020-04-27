//
//  HomeVC.h
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; // 1 热度 2 时间 3 关注
- (void)loadFromServeTTTT;
@property(nonatomic,assign)NSInteger pageNo;
@end
