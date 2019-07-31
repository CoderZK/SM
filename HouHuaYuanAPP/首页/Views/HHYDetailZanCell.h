//
//  HHYDetailZanCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HHYDetailZanCell;
@protocol HHYDetailZanCellDelegate <NSObject>

- (void)didClickZanHeadBtWithIndex:(NSInteger)index;


@end


@interface HHYDetailZanCell : UITableViewCell
@property(nonatomic,strong)UIButton *moreBt;
@property(nonatomic,strong)NSMutableArray *dataArray;//str
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArrayTwo;
@property(nonatomic,assign)id<HHYDetailZanCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
