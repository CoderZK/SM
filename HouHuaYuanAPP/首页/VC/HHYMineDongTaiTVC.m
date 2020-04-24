//
//  HHYMineDongTaiTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYMineDongTaiTVC.h"
#import "HHYHomeDongTaiCell.h"
#import "HHYGongGaoTVC.h"
@interface HHYMineDongTaiTVC ()<HHYHomeDongTaiCellDelegate,HHYYongBaoViewDeletage>
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIButton *centerBt;
@property(nonatomic,strong)UIButton *hitClickButton,*desBt,*desTwobt;
@property(nonatomic,strong)UIView *headV,*headTwoView;
@property(nonatomic,strong)UILabel *desLB;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)HHYYongBaoView *showView;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)BOOL isSubscribed;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong)UIButton *backBt,*editBt;



@end

@implementation HHYMineDongTaiTVC

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
    if (!self.isMine && !self.isHuaTi) {
        [self getDetailDataTWO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[HHYHomeDongTaiCell class] forCellReuseIdentifier:@"cellFour"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView reloadData];
    if (self.isMine || self.isHuaTi) {
        if (self.isMine) {
            self.navigationItem.title = @"我的动态";
             self.tableView.frame = CGRectMake(0,0, ScreenW, ScreenH);
            
            UIButton * hitClickButtonn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15,  sstatusHeight + 2,70, 40)];
            
            //    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
            [hitClickButtonn setTitle:@"编辑" forState:UIControlStateNormal];
            [hitClickButtonn setTitle:@"删除" forState:UIControlStateSelected];
            [hitClickButtonn sizeToFit];
            hitClickButtonn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            hitClickButtonn.titleLabel.font = kFont(14);
            [hitClickButtonn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [hitClickButtonn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            hitClickButtonn.tag = 11;
            self.editBt = hitClickButtonn;
            UIButton * hitClickButtonn1=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70 - 15,  sstatusHeight + 2,70, 40)];
            
            //    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
            [hitClickButtonn1 setTitle:@"返回" forState:UIControlStateNormal];
            
            hitClickButtonn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            hitClickButtonn1.titleLabel.font = kFont(14);
            [hitClickButtonn1 sizeToFit];
            [hitClickButtonn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [hitClickButtonn1 addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            hitClickButtonn1.tag = 12;
            hitClickButtonn1.hidden = YES;
            self.backBt = hitClickButtonn1;
            //    [self.view addSubview:hitClickButtonn];
            self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.editBt],[[UIBarButtonItem alloc] initWithCustomView:self.backBt]];
        }else {
             self.navigationItem.title = self.titleStr;
        }
    }else {
        
         [self setheadV];
        self.navigationItem.title = self.titleStr;
         self.tableView.frame = CGRectMake(0, 50, ScreenW, ScreenH - 50);
    }
    
    self.pageNo = 1;
    [self loadFromServeTTTT];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self loadFromServeTTTT];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadFromServeTTTT];
    }];
    
    
}

- (void)navigationItemButtonAction:(UIButton *)button {
    
    if  (button.tag == 11) {
        button.selected = !button.selected;
        self.isEdit = button.selected;
        self.backBt.hidden = !button.selected;
        if (!button.selected) {
            //删除
            NSMutableArray * arr = @[].mutableCopy;
            for (zkHomelModel * model  in self.dataArray) {
                if (model.isSelect) {
                    
                    [arr addObject:model.postId];
                    
                }
            }
            
            if (arr.count > 0) {
                [self deleteWithIds:arr];
            }
            
        }
        
        
    }else {
        
        for (zkHomelModel * model  in self.dataArray) {
            model.isSelect = NO;
        }
        self.backBt.hidden = YES;
        self.isEdit = NO;
        self.editBt.selected = NO;
        
    }
    
    [self.tableView reloadData];
    
    
}


- (void)deleteWithIds:(NSArray *)arr{
    
    

    
    [zkRequestTool networkingPOST:[HHYURLDefineTool deletePostURL] parameters:[arr componentsJoinedByString:@","] success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            NSMutableArray * arrTwo = @[].mutableCopy;
            for (zkHomelModel * model  in self.dataArray) {
                if (!model.isSelect) {
                    [arrTwo addObject:model];
                }
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:arrTwo];
            if (self.dataArray.count == 0 ) {
                self.editBt.hidden = YES;
            }else {
                self.editBt.hidden = NO;
            }
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (void)setheadV{
    
    self.headTwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
    self.headTwoView.backgroundColor = WhiteColor;
    [self.view addSubview:self.headTwoView];
    
    self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 20)];
    self.desLB.numberOfLines = 0;
    self.desLB.font = kFont(13);
    self.desLB.textColor = CharacterBlackColor;
    [self.headTwoView addSubview:self.desLB];

    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desLB.frame), ScreenW, 50)];
    self.headV.backgroundColor = [UIColor whiteColor];
    [self.headTwoView addSubview:self.headV];
    self.headTwoView.mj_h = CGRectGetMaxY(self.headV.frame);
    
    self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, 40)];
    self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.leftBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.leftBt setTitle:@"热门" forState:UIControlStateNormal];
    [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.leftBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.leftBt.titleLabel.font = kFont(15);
    self.leftBt.selected = YES;
    self.leftBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
    [self.headV addSubview:self.leftBt];
    self.leftBt.tag = 0;
    [self.leftBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  55, 0, 50, 40)];
    self.centerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.centerBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.centerBt setTitle:@"最新" forState:UIControlStateNormal];
    [self.centerBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.centerBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.centerBt.titleLabel.font = kFont(15);
    [self.headV addSubview:self.centerBt];
    self.centerBt.tag = 1;
    [self.centerBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.hitClickButton = [[UIButton alloc] initWithFrame:CGRectMake(15 +  110 , 0, 50, 40)];
    self.hitClickButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.hitClickButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.hitClickButton setTitle:@"关注" forState:UIControlStateNormal];
    [self.hitClickButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.hitClickButton setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.hitClickButton.titleLabel.font = kFont(15);
    [self.headV addSubview:self.hitClickButton];
    self.hitClickButton.tag = 2;
    [self.hitClickButton addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.desBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [self.desBt setImage: [UIImage imageNamed:@"21"] forState:UIControlStateNormal];
//    self.desBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.desBt.tag = 3;
//    [self.desBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.desTwobt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
//    [self.desTwobt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
//    [self.desTwobt setTitle:@"取消关注" forState:UIControlStateNormal];
//    self.desTwobt.titleLabel.font = kFont(14);
//    self.desTwobt.tag = 4;
//    [self.desTwobt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithCustomView:self.desTwobt];
//    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithCustomView:self.desBt];
//    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}


- (void)loadFromServeTTTT {
    
    [SVProgressHUD show];
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    //    dataDict[@"tagId"] = @(self.tagId);
    dataDict[@"pageNo"] = @(self.pageNo);
    dataDict[@"pageSize"] = @(10);
    if (self.isMine) {
        dataDict[@"createBy"] = [HHYSignleTool shareTool].session_uid;
    }else {
        dataDict[@"circleId"] = self.circleId;
        if (self.type == 0){
            dataDict[@"orderBy"] = @(2);
        }else if (self.type == 1) {
            dataDict[@"orderBy"] = @(1);
        }else if (self.type == 2){
            dataDict[@"subscribed"] = @(1);
        }
        dataDict[@"tagId"] = self.tagId;
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
                self.editBt.hidden = YES;
            }else {
                self.editBt.hidden = NO;
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



- (void)hitAction:(UIButton *)button {
    
    if (button.tag != 2) {
      self.type = button.tag;
    }
    if (button.tag == 0) {
        
        self.leftBt.selected = YES;
        self.leftBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.hitClickButton.selected = NO;
        self.hitClickButton.titleLabel.font = kFont(15);
        
        
    }else if (button.tag == 1) {
        self.centerBt.selected = YES;
        self.centerBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
        self.hitClickButton.selected = NO;
        self.hitClickButton.titleLabel.font = kFont(15);
    }else if (button.tag == 2) {
        
        if (![HHYSignleTool shareTool].isLogin){
            [self gotoLoginVC];
            return ;
        }
        self.type = button.tag;
        self.hitClickButton.selected = YES;
        self.hitClickButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
    }else if (button.tag == 3) {
       //介绍
        HHYGongGaoTVC * vc =[[HHYGongGaoTVC alloc] init];
        vc.cricleID = self.circleId;
        vc.cricleName = self.titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }else if (button.tag == 4) {
        //关注
        if (![HHYSignleTool shareTool].isLogin){
            [self gotoLoginVC];
            return ;
        }
        [self attentionAction];
        return;
        
    }
    self.pageNo = 1;
    [self loadFromServeTTTT];
    
}

- (void)attentionAction{
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"type"] = @"2";
    dataDict[@"userId"] = self.circleId;
    NSString * url = [HHYURLDefineTool addUserSubscribeURL];
    if (self.isSubscribed) {
        url = [HHYURLDefineTool deleteUserSubscribeURL];
    }
    [zkRequestTool networkingPOST:url parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.isSubscribed = !self.isSubscribed;
            if (self.isSubscribed) {
                [self.desTwobt setTitle:@"取消关注" forState:UIControlStateNormal];
                self.desTwobt.mj_w = 60;
            }else {
                [self.desTwobt setTitle:@"关注" forState:UIControlStateNormal];
                self.desTwobt.mj_w = 30;
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.dataArray[indexPath.row].cellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HHYHomeDongTaiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFour" forIndexPath:indexPath];
    cell.delegate = self;
    
    if (self.isMine) {
        cell.isDelete = self.isEdit;
    }
    
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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



#pragma mark ------ 点击cell 内部的按钮 ----
//0 头像 1 查看,2 评论 3 赞 ,4送花,5分享 6 点击查看原文
-(void)didClickButtonWithCell:(HHYHomeDongTaiCell *)cell andIndex:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (index == 0) {
        HHYZhuYeTVC * vc =[[HHYZhuYeTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.dataArray[indexPath.row].createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) {
        
    }else if (index == 2) {
        
        
        
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
        
    }else if (index == 6) {
        
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

- (void)getDetailDataTWO {
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getSysSocialCircleDetailURL] parameters:self.circleId success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            NSString * str  = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"subscribed"]];
            NSString *profile =  [NSString stringWithFormat:@"圈子说明: %@",responseObject[@"object"][@"profile"]];
            self.desLB.attributedText = [profile getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterBlackColor];
            self.desLB.mj_h = [profile getHeigtWithFontSize:13 lineSpace:3 width:ScreenW- 30];
            self.headV.mj_y = CGRectGetMaxY(self.desLB.frame);
            self.headTwoView.mj_h = CGRectGetMaxY(self.headV.frame);
            
             self.tableView.frame = CGRectMake(0, self.headTwoView.mj_h , ScreenW, ScreenH - self.headTwoView.mj_h - (sstatusHeight +44));
            
//            if ([str isEqualToString:@"0"]) {
//                self.isSubscribed = NO;
//            }else {
//                self.isSubscribed = YES;
//            }
//
//            if (self.isSubscribed) {
//                [self.desTwobt setTitle:@"取消关注" forState:UIControlStateNormal];
//                self.desTwobt.mj_w = 60;
//            }else {
//                [self.desTwobt setTitle:@"关注" forState:UIControlStateNormal];
//                self.desTwobt.mj_w = 30;
//            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}



@end

