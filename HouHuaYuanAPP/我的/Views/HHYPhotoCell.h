//
//  HHYPhotoCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HHYPhotoCell;
@protocol HHYPhotoCellDelegate <NSObject>

- (void)didClickView:(HHYPhotoCell *)cell isDelect:(BOOL)isDelect andIsAdd:(BOOL)isAdd withIndex:(NSInteger )index;

@end


@interface HHYPhotoCell : UITableViewCell

@property(nonatomic,assign)BOOL isDelect;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)id<HHYPhotoCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
