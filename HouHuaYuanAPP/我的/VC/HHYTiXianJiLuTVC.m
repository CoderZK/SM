//
//  HHYTiXianJiLuTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYTiXianJiLuTVC.h"
#import "HHYTiXianListCell.h"
@interface HHYTiXianJiLuTVC ()
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel*> *dataArray;
@end

@implementation HHYTiXianJiLuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray= @[].mutableCopy;
    self.navigationItem.title = @"提现记录";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYTiXianListCell" bundle:nil] forCellReuseIdentifier:@"cell"];

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

- (void)loadFromServeTTTT {
    
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"pageNo"] = @(self.pageNo);
    dataDict[@"pageSize"] = @(10);
    [zkRequestTool networkingPOST:[HHYURLDefineTool getMyWithDrawListURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            NSArray * arr = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]];
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
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHYTiXianListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = self.dataArray[indexPath.row].title;
    cell.timeLB.text = [NSString stringWithTime:self.dataArray[indexPath.row].createTime];
    cell.moneyLB.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row].flowerNum];
    if (self.dataArray[indexPath.row].status == 1) {
        cell.statusLB.text = @"审核中";
    }else if (self.dataArray[indexPath.row].status == 2) {
        cell.statusLB.text = @"提现成功";
    }else if (self.dataArray[indexPath.row].status == 3){
         cell.statusLB.text = @"提现失败";
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
