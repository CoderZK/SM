//
//  HomeVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HomeVC.h"
#import "HHYHomeOneCell.h"
#import "HHYHomeTwoCell.h"
#import "HHYHomeThreeCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HHYHomeDongTaiCell.h"
#import "zkHomelModel.h"
#import "HHYDetailTVC.h"
#import "HHYGongGaoTVC.h"
#import "HHYReDuTVC.h"
#import "HangQingVC.h"
#import "MineVC.h"
#import "HHYHomeFiveCell.h"
#import "HHYMineDongTaiTVC.h"
#import "LxmWebViewController.h"
#import "HHYShopingVC.h"
#import "JJJJGouWuHomeVC.h"

@interface HomeVC ()<SDCycleScrollViewDelegate,HHYHomeDongTaiCellDelegate,HHYYongBaoViewDeletage,UITabBarControllerDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)SDCycleScrollView *sdcycView;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *scrollDataArray;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)HHYYongBaoView *showView;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSArray *jiaArr;
@property(nonatomic,assign)NSInteger selectIndex; //tabbar 选中的第几个
@property(nonatomic,assign)NSInteger tagId;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArrayDaLei;

@end

@implementation HomeVC

- (NSMutableArray<HHYTongYongModel *> *)scrollDataArray {
    if (_scrollDataArray == nil) {
        _scrollDataArray = [NSMutableArray array];
    }
    return _scrollDataArray;
}

- (HHYYongBaoView *)showView {
    if (_showView == nil) {
        _showView = [[HHYYongBaoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showView.deletage = self;
    }
    return _showView;
}

- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHead) name:@"updateHead" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doubleClick) name:@"doubleClick" object:nil];
    
    
    
  
    [self getConfig];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)doubleClick {
    [self.tableView scrollsToTop];
    self.pageNo = 1;
    [self loadFromServeTTTT];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 0;
    self.dataArrayDaLei = @[].mutableCopy;
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
    self.titleArr = @[].mutableCopy;
    self.selectIndex = 0;
    self.tagId = 1;
    [self.tableView registerClass:[HHYHomeOneCell class] forCellReuseIdentifier:@"cellOne"];
    [self.tableView registerClass:[HHYHomeThreeCell class] forCellReuseIdentifier:@"cellThree"];
    [self.tableView registerClass:[HHYHomeDongTaiCell class] forCellReuseIdentifier:@"cellFour"];
    [self.tableView registerClass:[HHYHomeFiveCell class] forCellReuseIdentifier:@"cellFive"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYHomeTwoCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tabBarController.delegate = self;
    [self setHeadView];
    
    [self getBannerData];
    
    self.pageNo = 1;
    [self loadFromServeTTTT];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self loadFromServeTTTT];
        [self loadFromServeTTTTDaLei];
        [self getBannerData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadFromServeTTTT];
    }];
    [self loadFromServeTTTTDaLei];
    [self laji];
    
    
}

- (void)getConfig {
    [zkRequestTool networkingPOST:[HHYURLDefineTool getIosConfigURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
            
            //1为展示购物
            if ([[NSString stringWithFormat:@"%@",responseObject[@"object"][@"show"]] isEqualToString:@"1"]) {
                [HHYSignleTool shareTool].isUpdate = YES;
            }else {
                [HHYSignleTool shareTool].isUpdate = NO;
            }
            [HHYSignleTool shareTool].downUrl = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"downUrl"]];;
            [self updateHead];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    
}

   

- (void)loadFromServeTTTT {
    
    [SVProgressHUD show];
    NSMutableDictionary * dataDict = @{}.mutableCopy;
//    dataDict[@"tagId"] = @(self.tagId);
    dataDict[@"pageNo"] = @(self.pageNo);
    dataDict[@"pageSize"] = @(10);
    if (self.type == 0){
        dataDict[@"orderBy"] = @(2);
    }else if (self.type == 1) {
        dataDict[@"orderBy"] = @(1);
    }else if (self.type == 2){
        dataDict[@"subscribed"] = @(1);
    }
    [zkRequestTool networkingPOST:[HHYURLDefineTool getsearchURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
         [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 0) {
           
            
            NSArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
            if (self.pageNo == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            self.pageNo++;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

         [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }];
    
}


//设置头视图
- (void)setHeadView {
    self.headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, ScreenW * 3/4 )];
    self.headView.clipsToBounds = YES;
  
    self.headView.backgroundColor  = WhiteColor;
    
    UIButton * imgBt = [[UIButton alloc] initWithFrame:CGRectMake(0,0, ScreenW, 200)];
    [imgBt addTarget:self action:@selector(goShoping) forControlEvents:UIControlEventTouchUpInside];
    [imgBt setBackgroundImage:[UIImage imageNamed:@"222"] forState:UIControlStateNormal];
    [self.headView addSubview:imgBt];

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, ScreenW, ScreenW * 3/4 ) delegate:self placeholderImage:nil];
    cycleScrollView.autoScrollTimeInterval = 3;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotColor = [UIColor colorWithRed:80/255.0 green:72/255.0 blue:155/255.0 alpha:1.0];
    CGFloat aa = 15;
    cycleScrollView.placeholderImage =[UIImage imageNamed:@"new_picture_default-1"];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    self.sdcycView = cycleScrollView;
    [self.headView addSubview:cycleScrollView];
    
    if (isPPPPPP) {
        self.headView.mj_h =  200;
        self.sdcycView.hidden = YES;
    }else {
        self.headView.mj_h =  ScreenW * 3/4;
        self.sdcycView.hidden = NO;
    }
    
    self.tableView.tableHeaderView = self.headView;
    
}
- (void)updateHead {
    if (isPPPPPP) {
        self.headView.mj_h =  200;
        self.sdcycView.hidden = YES;
    }else {
        self.headView.mj_h =  ScreenW * 3/4;
        self.sdcycView.hidden = NO;
    }
    self.tableView.tableHeaderView = self.headView;
}
- (void)goShoping {
    if (![HHYSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    JJJJGouWuHomeVC * vc =[[JJJJGouWuHomeVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return self.dataArray.count;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 135;
        }else {
            return 0;
        }
    }else if(indexPath.section == 1){
        return 55;
    }else if (indexPath.section == 2) {
        return self.dataArray[indexPath.row].cellHeight;
    }
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HHYHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFive" forIndexPath:indexPath];
            cell.dataArray = self.dataArrayDaLei;
            Weak(weakSelf);
            cell.clickIndexBlock = ^(NSInteger index) {
                weakSelf.titleArr = weakSelf.jiaArr[index];
                 HHYMineDongTaiTVC* vc =[[HHYMineDongTaiTVC alloc] init];
                 vc.hidesBottomBarWhenPushed = YES;
                vc.circleId = weakSelf.dataArrayDaLei[index].ID;
                vc.titleStr = weakSelf.dataArrayDaLei[index].name;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else {
            HHYHomeTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://hbimg.b0.upaiyun.com/79f131b957a2e68fa97510f606eeecda97a7a0bd44d34-gnWqEC_fw658"]];
            cell.clipsToBounds = YES;
            return cell;
        }
    }else if (indexPath.section == 1) {
        __weak typeof(self) weakSelf = self;
        HHYHomeThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellThree" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectIndex = self.type;
        cell.dataArray = self.titleArr;
        cell.clickIndexBlock = ^(NSInteger index) {
            
            if (index == 2) {
                if (![HHYSignleTool shareTool].isLogin){
                    [weakSelf gotoLoginVC];
                    return ;
                }
                weakSelf.type = index;
                weakSelf.pageNo = 1;
                [weakSelf loadFromServeTTTT];
            }else {
                weakSelf.type = index;
                weakSelf.pageNo = 1;
                [weakSelf loadFromServeTTTT];
            }
            
        };
        return cell;
    }else if (indexPath.section == 2) {
        HHYHomeDongTaiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFour" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    HHYHomeOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        HHYDetailTVC * vc =[[HHYDetailTVC alloc] init];
        vc.ID = self.dataArray[indexPath.row].postId;
        Weak(weakSelf);
        vc.sendZanYesOrNoBlock = ^(BOOL isZan, NSInteger number) {
            weakSelf.dataArray[indexPath.row].currentUserLike = isZan;
            weakSelf.dataArray[indexPath.row].likeNum = number;
            [weakSelf.tableView reloadData];
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
    NSLog(@"%@",@"123456");
    
//    [self doubleClick];
    

    
}

#pragma mark ----- 轮播图的点击 --------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    HHYTongYongModel * model = self.scrollDataArray[index];
    if (model.url.length > 0) {
        LxmWebViewController *vc = [[LxmWebViewController alloc] init];
        vc.loadUrl = [NSURL URLWithString:model.url];
        vc.navigationItem.title = model.name;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ------ 点击cell 内部的按钮 ----
//0 头像 1 查看,2 评论 3 赞 ,4送花,5分享 6 点击查看原文
-(void)didClickButtonWithCell:(HHYHomeDongTaiCell *)cell andIndex:(NSInteger)index {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (index == 0) {
        HHYZhuYeTVC * vc =[[HHYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.dataArray[indexPath.row].createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 3) {
        if (![HHYSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self zanActionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
    }else if (index == 4) {
        if (![HHYSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        if ([[HHYSignleTool shareTool].session_uid isEqualToString:self.dataArray[indexPath.row].createBy]) {
            [SVProgressHUD showErrorWithStatus:@"自己不能给自己送花"];
            return;
        }
        [self.showView showWithIndexPath:indexPath];
        
    }else if (index == 5) {
           [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)] withUrl:nil shareModel:self.dataArray[indexPath.row]];
    }else if (index == 7) {
        
        if (![HHYSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return;
        }
        [self collectionWithModel:self.dataArray[indexPath.row] WithIndePath:indexPath];
    }else if (index >=100) {
        
        zkHomelModel * model =  self.dataArray[indexPath.row];
        NSArray * arr = [model.tagId componentsSeparatedByString:@","];
        NSArray * arrTwo = [model.tagName componentsSeparatedByString:@","];
        
        if (index-100<arr.count) {
            HHYMineDongTaiTVC * vc =[[HHYMineDongTaiTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isMine = NO;
            vc.titleStr = arrTwo[index-100];
            vc.tagId = arr[index - 100];
            vc.circleId = model.circledId;
            vc.isHuaTi = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
    }
}

- (void)zanActionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"postId"] = model.postId;
    dataDict[@"type"] = @"1";
    NSString * url = [HHYURLDefineTool getlikeURL];
    if (model.currentUserLike) {
       url = [HHYURLDefineTool notlikeURL];
    }
    [zkRequestTool networkingPOST:url parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            model.currentUserLike = !model.currentUserLike;
            if (model.currentUserLike) {
                model.likeNum = model.likeNum + 1;
            }else {
               model.likeNum = model.likeNum  - 1;
            }
             [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
   

            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

//收藏或者取消操作
- (void)collectionWithModel:(zkHomelModel *)model WithIndePath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"targetId"] = self.dataArray[indexPath.row].postId;
    dataDict[@"type"] = @"2";
    NSString * url = [HHYURLDefineTool addMyCollectionURL];
    if (model.currentUserCollect) {
       url = [HHYURLDefineTool deleteMyCollectionURL];
        [zkRequestTool networkingPOST:url parameters:self.dataArray[indexPath.row].postId success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }else {
        [zkRequestTool networkingPOST:url parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if ([responseObject[@"code"] intValue]== 0) {
                
                if (model.currentUserCollect) {
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏帖子成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"收藏帖子成功"];
                }
                model.currentUserCollect = !model.currentUserCollect;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
                
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
    }
    
    
    
}

#pragma  mark ---- 点击 抱一抱 的内容 ----
- (void)didClcikIndex:(NSInteger)index withIndexPath:(NSIndexPath *)indexPath WithNumber:(nonnull NSString *)str{
    
    if (index == 4) {
        [self.showView diss];
        HHYReDuTVC * vc =[[HHYReDuTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        Weak(weakSelf);
        [self sendFlowerWithNumber:str andLinkId:self.dataArray[indexPath.row].postId andIsGiveUser:NO result:^(BOOL isOK) {
            if (isOK) {
                [SVProgressHUD showSuccessWithStatus:@"送花成功!"];
                weakSelf.dataArray[indexPath.row].heat += [str integerValue];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            }
            
            
        }];
    }
    
}


#pragma mark ----- 点击tabbar -----

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    BaseNavigationController * vc = (BaseNavigationController *)viewController;
  
    BaseTableViewController * tvc = (BaseTableViewController *)[vc.childViewControllers firstObject];
    
//    if (([tvc isKindOfClass:[HangQingVC class]] || [tvc isKindOfClass:[MineVC class]]) && ![HHYSignleTool shareTool].isLogin) {
//        [self gotoLoginVC];
//        return NO;
//    }
    
    if(viewController == tabBarController.selectedViewController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"doubleClick" object:nil];
     }
    return YES;
    NSLog(@"===\n%@",viewController);
    NSLog(@"+++++\n%@",vc.childViewControllers);

    
    
    
    return YES;
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (self.selectIndex == tabBarController.selectedIndex) {
        //重复点击内容
        
    }else {
        self.selectIndex = tabBarController.selectedIndex;
    }
    
    
    NSLog(@"---------\n%d",[self.tabBarController.selectedViewController isEqual:viewController]);

    
    
}


- (void)getBannerData {
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getBannerListURL] parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 0) {
         
            self.scrollDataArray = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            NSMutableArray * arr = @[].mutableCopy;
            for (HHYTongYongModel * model  in self.scrollDataArray) {
                [arr addObject:[HHYURLDefineTool getImgURLWithStr:model.pic]];
            }
            self.sdcycView.imageURLStringsGroup = arr;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}


- (void)loadFromServeTTTTDaLei {
    
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getSysSocialCircleListURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArrayDaLei = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)laji {
    for (int i = 0 ; i < 5; i++) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
