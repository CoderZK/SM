//
//  HHYMakeFriendsTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHYMakeFriendsTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isHot;
- (void)loadFromServeTTTT;
@property(nonatomic,assign)NSInteger pageNo;
@end

NS_ASSUME_NONNULL_END
