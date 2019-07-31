//
//  HHYYongBaoView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYYongBaoView;
@protocol HHYYongBaoViewDeletage <NSObject>

- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(NSString * )str;

@end

@interface HHYYongBaoView : UIView
- (void)showWithIndexPath:(NSIndexPath *)indexPath;
- (void)diss;
@property(nonatomic,assign)id<HHYYongBaoViewDeletage>deletage;
@end

NS_ASSUME_NONNULL_END
