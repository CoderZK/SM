//
//  HHYGoodDetailTVC.h
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/13.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "BaseTableViewController.h"
#import "HHYHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHYGoodDetailTVC : BaseTableViewController
@property(nonatomic,strong)HHYHomeModel *model;
/**  */
@property(nonatomic , assign)NSInteger  index;
@end

NS_ASSUME_NONNULL_END
