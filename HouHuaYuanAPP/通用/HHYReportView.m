//
//  HHYReportView.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYReportView.h"
static HHYReportView * danli = nil;

@implementation HHYReportView

- (UIView *)clearView {
    if (_clearView == nil) {
        _clearView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, ScreenH)];
        _clearView.backgroundColor =[UIColor colorWithWhite:1 alpha:0];
        
        
        
    }
    return _clearView;
}


- (UIButton *)cancelBt {
    if (_cancelBt == nil) {
        _cancelBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBt.frame = CGRectMake(0, ScreenH - 50 + 200, ScreenW, 50);
        _cancelBt.tag = 100;
        _cancelBt.titleLabel.font =[UIFont systemFontOfSize:18];
        [_cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBt.backgroundColor = WhiteColor;
        
    }
    
    return _cancelBt;
}



+ (HHYReportView *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        danli = [[HHYReportView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        danli.backgroundColor =[UIColor colorWithWhite:0 alpha:0.1];
        
    });
    
    return danli;
}

+ (void)showWithArray:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath{
    
    [HHYReportView shareInstance].indexPath = indexPath;
    [[HHYReportView shareInstance].subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[HHYReportView shareInstance].clearView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[HHYReportView shareInstance] addSubview:[HHYReportView shareInstance].clearView];
    [HHYReportView shareInstance].clearView.hidden = NO;
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:[HHYReportView shareInstance]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HHYReportView shareInstance] show];
    });
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:[HHYReportView shareInstance] action:@selector(removeV)];
    [[HHYReportView shareInstance] addGestureRecognizer:tap];
    for (int i = 0 ; i < arr.count ; i++) {
        UIButton *customBT =[UIButton buttonWithType:UIButtonTypeCustom];
        customBT.frame = CGRectMake(0, ScreenH - 50  - (i+1) * 50, ScreenW, 50);
        if (sstatusHeight > 20) {
            customBT.frame = CGRectMake(0, ScreenH - 50 - (i+1) * 50 - 34, ScreenW, 50);
        }
        [customBT setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        [customBT setTitle:arr[arr.count - 1 - i] forState:UIControlStateNormal];
        customBT.backgroundColor = [UIColor whiteColor];
        customBT.titleLabel.font = [UIFont systemFontOfSize:18];
        [[HHYReportView shareInstance].clearView addSubview:customBT];
        customBT.tag = arr.count - 1 - i;
        [customBT addTarget:[HHYReportView shareInstance] action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView * view  = [[UIView alloc] initWithFrame:CGRectMake(10, 49.4, ScreenW -20 , 0.6)];
        view.backgroundColor = lineBackColor;
        [customBT addSubview:view];
    }
    [[HHYReportView shareInstance].clearView addSubview:[HHYReportView shareInstance].cancelBt];
    [[HHYReportView shareInstance].cancelBt addTarget:[HHYReportView shareInstance] action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
    [[HHYReportView shareInstance] addGestureRecognizer:tap];
}

- (void)removeV {
    [[HHYReportView shareInstance] diss];
}


- (void)hitAction:(UIButton *)customBT  {
    if (customBT.tag == 100) {
        [[HHYReportView shareInstance] diss];
    }else {
        [[HHYReportView shareInstance] diss];
        if ([HHYReportView shareInstance].delegate != nil && [self.delegate respondsToSelector:@selector(didSelectAtIndex:withIndexPath:)]) {
            [[HHYReportView shareInstance].delegate didSelectAtIndex:customBT.tag withIndexPath:self.indexPath];
        }
    }
}

- (void)show {
    
    [UIView animateWithDuration:0.25 animations:^{
        [HHYReportView shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [HHYReportView shareInstance].clearView.y = 0;
        [HHYReportView shareInstance].cancelBt.y = ScreenH - 50;
        if (sstatusHeight > 20) {
            [HHYReportView shareInstance].cancelBt.y = ScreenH - 50 - 34 ;
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)diss {
    [UIView animateWithDuration:0.25 animations:^{
        [HHYReportView shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [HHYReportView shareInstance].clearView.y = ScreenH;
        [HHYReportView shareInstance].cancelBt.y = ScreenH - 50 + 200;
    } completion:^(BOOL finished) {
        [[HHYReportView shareInstance] removeFromSuperview];
    }];
}

+ (void)diss {
    [UIView animateWithDuration:0.25 animations:^{
        [HHYReportView shareInstance].backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [HHYReportView shareInstance].clearView.y = ScreenH;
        [HHYReportView shareInstance].cancelBt.y = ScreenH - 50 + 200;
    } completion:^(BOOL finished) {
        [[HHYReportView shareInstance] removeFromSuperview];
    }];
}
@end
