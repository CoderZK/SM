//
//  UITabBar+RedTabBar.h
//  54school
//
//  Created by 宋乃银 on 2018/9/10.
//  Copyright © 2018年 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedTabBar)

/**
 *  显示小红点
 *
 *  @param index 传入需要现实的位置
 */
- (void)showBadgeIndex:(NSInteger)index;

/**
 *  隐藏小红点
 *
 *  @param index 传入需要隐藏的位置
 */
- (void)hideBadgeIndex:(NSInteger)index;

@end
