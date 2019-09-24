//
//  HHYShowViewTWO.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HHYShowViewTWODelegate <NSObject>
- (void)didClickIndex:(NSInteger)index;
- (void)didSelctStr:(NSString *)str idStr:(NSString *)idStr;
@end
@interface HHYShowViewTWO : UIView
@property(nonatomic , assign)id<HHYShowViewTWODelegate>deleate;
- (void)show;
@property(nonatomic , assign)BOOL isShow;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@property(nonatomic , strong)UIView *blackView;
- (void)diss;
@end

NS_ASSUME_NONNULL_END
