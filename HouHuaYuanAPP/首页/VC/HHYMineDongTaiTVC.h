//
//  HHYMineDongTaiTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHYMineDongTaiTVC : BaseTableViewController
@property(nonatomic,strong)NSString *circleId;
@property(nonatomic,assign)BOOL isMine,isHuaTi;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *tagId;
@end

NS_ASSUME_NONNULL_END
