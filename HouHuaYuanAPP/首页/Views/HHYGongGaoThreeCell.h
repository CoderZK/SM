//
//  HHYGongGaoThreeCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYDetailZanCell;
@protocol HHYGongGaoThreeCellegate <NSObject>

- (void)didClickGuanZhuBtWithIndex:(NSInteger)index;


@end


@interface HHYGongGaoThreeCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,assign)id<HHYGongGaoThreeCellegate>delegate;
@property(nonatomic,strong)NSString *numberStr;
@end

NS_ASSUME_NONNULL_END
