//
//  HHYGuanZhuHeadTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHYGuanZhuHeadTVC : BaseTableViewController
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,assign)BOOL isQuanZi;
@end


@interface HHYGuanZhuBT : UIButton

@end


NS_ASSUME_NONNULL_END
