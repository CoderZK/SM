//
//  HHYHuaDuoFiveCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYHuaDuoFiveCell;

@protocol HHYHuaDuoFiveCellDelegate <NSObject>

- (void)didClickCell:(HHYHuaDuoFiveCell *)cell index:(NSInteger )index;

@end


@interface HHYHuaDuoFiveCell : UITableViewCell

@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@property(nonatomic,assign)id<HHYHuaDuoFiveCellDelegate>delegate;

@end

@interface huoDuoBt : UIButton
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3,*LB4;
@property(nonatomic,strong)UIButton *gouBt;
@end


NS_ASSUME_NONNULL_END
