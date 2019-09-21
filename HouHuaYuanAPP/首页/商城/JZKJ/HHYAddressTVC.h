//
//  HHYAddressTVC.h
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "BaseTableViewController.h"
#import "HHYHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHYAddressTVC : BaseTableViewController
/**  */
@property(nonatomic , copy)void(^sendAddressBlock)(HHYHomeModel *model);
@end

NS_ASSUME_NONNULL_END
