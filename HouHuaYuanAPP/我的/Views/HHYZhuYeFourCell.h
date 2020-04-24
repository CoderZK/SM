//
//  HHYZhuYeFourCell.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHYZhuYeFourCell : UITableViewCell
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIImageView *gotoImgV;
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UILabel *titleLB,*biaoQianLB;
@property(nonatomic,assign)NSInteger type; // 0 主页使用 1 编辑资料使用

@property(nonatomic,strong)HHYUserModel  *model;
@property(nonatomic,strong)NSString *qianMingStr;

@end

NS_ASSUME_NONNULL_END
