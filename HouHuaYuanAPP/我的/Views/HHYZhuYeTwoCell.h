//
//  HHYZhuYeTwoCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYZhuYeTwoCell;

@protocol HHYZhuYeTwoCellDelegate <NSObject>

- (void)didClickGuanZhuOrFansWith:(NSInteger )index;

@end

@interface HHYZhuYeTwoCell : UITableViewCell
@property(nonatomic,strong)HHYUserModel *model;
@property(nonatomic,assign)id<HHYZhuYeTwoCellDelegate>delegate;
@property(nonatomic,strong)UIButton  *guanZhuBt;
@end

NS_ASSUME_NONNULL_END
