//
//  HHYHomeModel.h
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/8.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHYHomeModel : NSObject
@property(nonatomic,strong)NSString *img,*title,*des,*desTwo,*content,*name,*phone,*address,*userID;
@property(nonatomic,assign)NSInteger ID,status;
@property(nonatomic , strong)NSString *goodId;
@property(nonatomic,assign)float price;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
