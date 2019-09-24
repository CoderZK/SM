//
//  HHYReportView.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HHYReportViewDelegate <NSObject>
//弹出的的时候点击的第几行
- (void)didSelectAtIndex:(NSInteger )index withIndexPath:(NSIndexPath *)indexPath;
@end
@interface HHYReportView : UIView
@property (nonatomic , strong)UIView * clearView;
@property (nonatomic , strong)UIButton * cancelBt;
@property(nonatomic,strong)NSIndexPath *indexPath;
+(HHYReportView *)shareInstance;
//在当前界面点击分享
+ (void)didSlectShar;
+ (void)showWithArray:(NSArray *)arr withIndexPath:(NSIndexPath *)indexPath;
+ (void)diss;
/*dialing*/
@property (nonatomic , assign)id<HHYReportViewDelegate> delegate;
@end

