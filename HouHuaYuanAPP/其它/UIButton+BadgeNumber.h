//
//  UIButton+BadgeNumber.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BadgeNumber)
- (void)setBadge:(NSString *)number andFont:(int)font;
- (void)setNumber:(NSString *)number andFont:(int )font;
@end

NS_ASSUME_NONNULL_END
