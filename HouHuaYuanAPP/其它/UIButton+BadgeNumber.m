//
//  UIButton+BadgeNumber.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "UIButton+BadgeNumber.h"

@implementation UIButton (BadgeNumber)
- (void)setBadge:(NSString *)number andFont:(int)font{
    UILabel * LB = (UILabel *)[self viewWithTag:100];
    if (LB != nil) {
        [LB removeFromSuperview];
    }
    CGFloat width = self.bounds.size.width;
    CGSize size = [@"1" getSizeWithMaxSize:CGSizeMake(900, 900) withFontSize:font];
    UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(width*7/10, -width/10, width/3+(number.length-1)*size.width, width/3)];
    numberLB.tag = 100;
    if (number.length > 2) {
        number =  [NSString stringWithFormat:@"%@+",@"99"];
        numberLB.x -= 5;
        numberLB.width =width/3+(3-1)*size.width;
    }
    numberLB.text = number;
    numberLB.textAlignment = NSTextAlignmentCenter;
    numberLB.font = [UIFont systemFontOfSize:font];
    numberLB.backgroundColor = [UIColor redColor];
    numberLB.textColor = [UIColor whiteColor];
    numberLB.layer.cornerRadius = width/6;
    numberLB.layer.masksToBounds = YES;
    if ([number isEqualToString:@"0"]  || [number isEqualToString:@"(null)"] || [number isEqualToString:@"<null>"]) {
        numberLB.hidden = YES;
    }else {
        numberLB.hidden = NO;
    }
    
    [self addSubview:numberLB];
}

- (void)setNumber:(NSString *)number andFont:(int )font {
    UILabel * LB = (UILabel *)[self viewWithTag:100];
    [LB removeFromSuperview];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGSize size = [@"1" getSizeWithMaxSize:CGSizeMake(900, 900) withFontSize:font];
    UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(width*4/5,-height / 5 , 12+(number.length-1)*size.width, 12)];
    numberLB.tag = 100;
    if (number.length > 2) {
        number =  [NSString stringWithFormat:@"%@+",@"99"];
        numberLB.x -= 5;
        numberLB.width =width/3+(3-1)*size.width;
    }
    numberLB.text = number;
    numberLB.textAlignment = NSTextAlignmentCenter;
    numberLB.font = [UIFont systemFontOfSize:font];
    numberLB.backgroundColor = [UIColor redColor];
    numberLB.textColor = [UIColor whiteColor];
    numberLB.layer.cornerRadius = 6;
    numberLB.layer.masksToBounds = YES;
    if ([number isEqualToString:@"0"]  || [number isEqualToString:@"(null)"] || [number isEqualToString:@"<null>"]) {
        numberLB.hidden = YES;
    }else {
        numberLB.hidden = NO;
    }
    [self addSubview:numberLB];
    
    
}
@end
