//
//  HHYXingQuBiaoQianTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHYXingQuBiaoQianTVC : BaseTableViewController

@property(nonatomic,strong)NSString *tagsID;

@property(nonatomic,copy)void(^sendBiaoQianBlock)(NSArray<HHYTongYongModel *> * arr,NSString * jionTitleStr,NSString *jionIdStr);

@property(nonatomic,assign)BOOL isZhuYe;

@end

NS_ASSUME_NONNULL_END
