//
//  HHYGongGaoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYGongGaoTVC.h"
#import "HHYGongGaoOneCell.h"
#import "HHYGongGaoTwoCell.h"
#import "HHYGongGaoThreeCell.h"
#import "HHYGuanZhuHeadTVC.h"
@interface HHYGongGaoTVC ()<HHYGongGaoThreeCellegate>
@property(nonatomic,strong)zkHomelModel *dataModel;
@end

@implementation HHYGongGaoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"圈子详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYGongGaoOneCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYGongGaoTwoCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[HHYGongGaoThreeCell class] forCellReuseIdentifier:@"cell3"];
    self.tableView.estimatedRowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self getDetailData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDetailData];
    }];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section == 1) {
        return UITableViewAutomaticDimension;
    }
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HHYGongGaoOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",[self.cricleID integerValue] - 1]];
        cell.titleLB.text = self.cricleName;
        
        [cell.guanZhuBt addTarget:self action:@selector(guanZhuAction) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.dataModel.subscribed) {
            cell.wwcon.constant= 100;
            [cell.guanZhuBt setTitle:@"取消关注" forState:UIControlStateNormal];
        }else {
            cell.wwcon.constant= 70;
            [cell.guanZhuBt setTitle:@"关注" forState:UIControlStateNormal];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        
        NSArray * arr = @[self.dataModel.announcement,self.dataModel.profile];
        
        HHYGongGaoTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLB.text = @"公告";
        }else{
            cell.titleLB.text = @"简介";
        }
        cell.contentLB.attributedText =[arr[indexPath.row] getMutableAttributeStringWithFont:14 lineSpace:5 textColor:CharacterBlackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {

        HHYGongGaoThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.numberStr = self.dataModel.fansNum;
        cell.dataArray = self.dataModel.fansList;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)guanZhuAction{
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"2";
    dict[@"userId"] = self.cricleID;
    NSString * url = [HHYURLDefineTool addUserSubscribeURL];
    if (self.dataModel.subscribed) {
        url = [HHYURLDefineTool deleteUserSubscribeURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            if (self.dataModel.subscribed) {
                
                for (zkHomelModel * model  in self.dataModel.fansList) {
                    if ([model.userId isEqualToString:[zkSignleTool shareTool].session_uid]) {
                        [self.dataModel.fansList removeObject:model];
                        break ;
                    }
                }
            }else {
                zkHomelModel * model = [[zkHomelModel alloc] init];
                model.avatar = [zkSignleTool shareTool].img;
                model.nickName = [zkSignleTool shareTool].nickName;
                model.userId = [zkSignleTool shareTool].session_uid;
                [self.dataModel.fansList addObject:model];
                
            }
            self.dataModel.subscribed = !self.dataModel.subscribed;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


#pragma  mark ----- 点击关注的人 -----
- (void)didClickGuanZhuBtWithIndex:(NSInteger)index {
    
    HHYZhuYeTVC * vc =[[HHYZhuYeTVC alloc] init];
    vc.userId = self.dataModel.fansList[index].userId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        if(self.dataModel.fansList.count == 0) {
            return;
        }
        HHYGuanZhuHeadTVC * vc =[[HHYGuanZhuHeadTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isQuanZi = YES;
        vc.dataArray = self.dataModel.fansList;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)getDetailData {
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getSysSocialCircleDetailURL] parameters:self.cricleID success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.dataModel = [zkHomelModel mj_objectWithKeyValues:responseObject[@"object"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}



@end
