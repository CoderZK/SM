//
//  HHYHomeFiveCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHYHomeFiveCell : UITableViewCell
@property(nonatomic,copy)void(^clickIndexBlock)(NSInteger index);
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@end


@interface fiveView : UIView
@property(nonatomic,strong)UIImageView *imgV,*imgVTwo;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *bt;

@end

NS_ASSUME_NONNULL_END
