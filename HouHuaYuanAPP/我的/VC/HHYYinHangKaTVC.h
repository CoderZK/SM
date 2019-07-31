//
//  HHYYinHangKaTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHYYinHangKaTVC : BaseTableViewController
@property(nonatomic,copy)void(^sendCarBlock)(HHYTongYongModel *model);
@end

NS_ASSUME_NONNULL_END
