//
//  HHYMinePhotoTVC.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHYMinePhotoTVC : BaseTableViewController
@property(nonatomic,strong)NSString *photos;
@property(nonatomic,copy)void(^sendPhotosBlock)(NSString * str);
@property(nonatomic,assign)NSInteger maxPhotos;
@end

NS_ASSUME_NONNULL_END
