//
//  MineVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "MineVC.h"
#import "HHYMineOneCell.h"
#import "HHYMineTwoCell.h"
#import "HHYMineThreeCell.h"
#import "HHYMineFourCell.h"
#import "HHYMineFriendsTVC.h"
#import "HHYReDuTVC.h"
#import "HHYKaiTongHuiYuanTVC.h"
#import "HHYZhuYeTVC.h"
#import "HHYXiuGaiZiLiaoTVC.h"
#import "HHYMineCollectTVC.h"
#import "HHYMinePhotoTVC.h"
#import "HHYMineDongTaiTVC.h"
#import "HHYMineTaskTVC.h"
#import "HHYShiMingRenZhengTVC.h"
#import "HHYXiaoFeiVC.h"
#import "HHYYiJianTVC.h"
#import "HHYTiXianTVC.h"
#import "HHYSettingTVC.h"


//#import "HHYGouWuChe.h"
//#import "HHYMineGouWuListTVC.h"
//#import "HHYAddressTVC.h"

@interface MineVC ()<HHYMineFourCellDelegate>
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)HHYUserModel *dataModel;
@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadFromServeTTTT];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"个人中心";
    
    [self.tableView registerClass:[HHYMineThreeCell class] forCellReuseIdentifier:@"cellThree"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYMineOneCell" bundle:nil] forCellReuseIdentifier:@"cellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYMineTwoCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYMineFourCell" bundle:nil] forCellReuseIdentifier:@"cellFour"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.titleArr = @[@[],@[],@[],@[@"我的主页",@"我的动态",@"谁看过我",@"我的相册",@"我的收藏",@"我的黑名单"],@[@"任务中心",@"实名认证",@"会员服务",@"我的订单",@"我的提现",@"意见反馈"]];
    
    
    UIButton * hitClickButtonn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"85"] forState:UIControlStateNormal];
    [hitClickButtonn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    hitClickButtonn.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hitClickButtonn];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadFromServeTTTT];
    }];
}

- (void)loadFromServeTTTT {
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[HHYURLDefineTool getMyInfoCenterURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.dataModel = [HHYUserModel mj_objectWithKeyValues:responseObject[@"object"]];
            [HHYSignleTool shareTool].nickName = self.dataModel.nickName;
            [HHYSignleTool shareTool].img = self.dataModel.avatar;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


//设置
- (void)navigationItemButtonAction:(UIButton *)button {
    
    HHYSettingTVC  * vc =[[HHYSettingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.phoneStr = self.dataModel.phone;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section <3) {
        return 1;
    }
    if (section == 5) {
        return 3;
    }
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3 || section == 4) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    if (footV == nil) {
        footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        footV.backgroundColor = BackgroundColor;
    }
    return footV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 65;
    }else if (indexPath.section == 1) {
        return 80;
    }else if (indexPath.section == 2) {
        if (isPPPPPP) {
            return 0;
        }
        return (ScreenW- 40) / 2 * (5/17.0) + 30;
    }
    if ((indexPath.section == 4 && indexPath.row == 2 && isPPPPPP) || (indexPath.section == 4 && indexPath.row == 4 && isPPPPPP) ||(indexPath.section == 4 && indexPath.row == 3 && isPPPPPP)||(indexPath.section == 3 && indexPath.row == 2 && isPPPPPP)){
        return 0;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HHYMineOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headBt addTarget:self action:@selector(gotoZhuYe) forControlEvents:UIControlEventTouchUpInside];
        [cell.ccopyBt addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.dataModel;
        cell.imgV.hidden = !self.dataModel.isVip;
        return cell;
    }else if (indexPath.section == 1) {
        HHYMineFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFour" forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = self.dataModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        HHYMineTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
        [cell.leftBt addTarget:self action:@selector(huiYuanOrZiLiaoAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.hitClickButton addTarget:self action:@selector(huiYuanOrZiLiaoAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.clipsToBounds = YES;
        return cell;
    }else {
        HHYMineThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellThree" forIndexPath:indexPath];
        cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld-%ld",indexPath.section-3,indexPath.row]];
        cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![HHYSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self gotoZhuYe];
        }else if (indexPath.row == 1) {
            HHYMineDongTaiTVC * vc =[[HHYMineDongTaiTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isMine = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            
            if (!self.dataModel.isVip) {
               
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只有开通Vip会员才能查看谁看过我" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"开通会员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    HHYKaiTongHuiYuanTVC * vc =[[HHYKaiTongHuiYuanTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.nickName = self.dataModel.nickName;
                    vc.imgStr = self.dataModel.avatar;
                    [self.navigationController pushViewController:vc animated:YES];
                            
                            
                   
                }];

                [ac addAction:action1];
                [ac addAction:action2];
                
                [self.navigationController presentViewController:ac animated:YES completion:nil];
                
                
            }
            
            HHYMineFriendsTVC * vc =[[HHYMineFriendsTVC alloc] init];
            vc.type = 3;
            vc.userNo = self.dataModel.userNo;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 3) {
            
            HHYMinePhotoTVC * vc =[[HHYMinePhotoTVC alloc] init];
            vc.photos = self.dataModel.photos;
            if (self.dataModel.isVip) {
                vc.maxPhotos = 20;
            }else {
                vc.maxPhotos = 10;
            }
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 4) {
            HHYMineCollectTVC * vc =[[HHYMineCollectTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 5) {
            HHYMineFriendsTVC * vc =[[HHYMineFriendsTVC alloc] init];
            vc.type = 4;
            vc.userNo = self.dataModel.userNo;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            HHYMineTaskTVC * vc =[[HHYMineTaskTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            HHYShiMingRenZhengTVC * vc =[[HHYShiMingRenZhengTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            
            HHYKaiTongHuiYuanTVC * vc =[[HHYKaiTongHuiYuanTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.nickName = self.dataModel.nickName;
            vc.imgStr = self.dataModel.avatar;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 3) {
            
            HHYXiaoFeiVC * vc =[[HHYXiaoFeiVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 4) {
           
            HHYTiXianTVC * vc =[[HHYTiXianTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.flowerNumber = [NSString stringWithFormat:@"%ld",self.dataModel.flowerNum];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if (indexPath.row == 5) {
            HHYYiJianTVC * vc =[[HHYYiJianTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
//    else if(indexPath.section == 5) {
//        if (indexPath.row == 0) {
//            HHYGouWuChe * vc =[[HHYGouWuChe alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else if (indexPath.row == 1) {
//            HHYMineGouWuListTVC* vc =[[HHYMineGouWuListTVC alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else if (indexPath.row == 2) {
//           HHYAddressTVC* vc =[[HHYAddressTVC alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//
//    }
    
    
}

//复制
- (void)copyAction {
    [SVProgressHUD showSuccessWithStatus:@"已经复制到粘贴板"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.dataModel.userNo;
    
}

//去主页
- (void)gotoZhuYe{
    HHYZhuYeTVC * vc =[[HHYZhuYeTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataModel.userId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- 点击了会员和修改资料 ----
- (void)huiYuanOrZiLiaoAction:(UIButton *)button {
    if (button.tag == 100) {
        //点击了开通会员
        HHYKaiTongHuiYuanTVC * vc =[[HHYKaiTongHuiYuanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.nickName = self.dataModel.nickName;
        vc.imgStr = self.dataModel.avatar;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //点击了修改资料
        HHYXiuGaiZiLiaoTVC * vc =[[HHYXiuGaiZiLiaoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

#pragma mark ---- 点击了关注粉丝一栏 -----
- (void)didClickView:(HHYMineFourCell *)cell withIndex:(NSInteger)index {
    if (index == 3) {
        if (isPPPPPP) {
            return;
        }
        HHYReDuTVC * vc =[[HHYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        HHYMineFriendsTVC * vc =[[HHYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userNo = self.dataModel.userNo;
        vc.type = index;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
