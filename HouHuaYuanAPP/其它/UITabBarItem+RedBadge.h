//
//  UITabBarItem+RedBadge.h
//  54school
//
//  Created by 宋乃银 on 2018/9/10.
//  Copyright © 2018年 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (RedBadge)

/**
 * 显示小红点
 * 需要在哪个item上面显示红点时，就用那个item调用
 */
- (void)showBadge;

/**
 * 隐藏小红点
 * 需要隐藏哪个item上面红点时，就用那个item调用
 */
- (void)hidenBadge;

@end
