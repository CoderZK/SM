// 
// ASpamCode_Public.m
// Created by apple on 2019/09/23
// 
// Copyright © 2019年 apple. All rights reserved.
//


#import "ASpamCode_Public.h"
#import "LAJIDDDDD_En_Viewcontroller.h" 
@implementation ASpamCode_Public 
#pragma mark:方便别人阅读自己代码这样就能实现OC调用JS 方法 
 + (void)main_X10_Call:(NSString *)arg1 msg_X13_:(NSString *)msg_X13_ {
    NSLog(@"function:%s line:", __FUNCTION__);

    [msg_X13_ substringFromIndex:1];

    [msg_X13_ isEqualToString:@"cosmopolitan"];

    NSLog(@"%@===%@", msg_X13_,@"viewController");

    //调用LAJIDDDDD_En_Viewcontroller 
 [LAJIDDDDD_En_Viewcontroller G9X_ac_X19_serendipity_A8P:arg1 of_X12_:msg_X13_];

}


@end
