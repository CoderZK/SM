//
//  HHYQuanZiGuiZeListTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYQuanZiGuiZeListTVC.h"
#import "HHYTongYongTwoCell.h"
@interface HHYQuanZiGuiZeListTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@end

@implementation HHYQuanZiGuiZeListTVC

- (NSMutableArray<HHYTongYongModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"圈子列表";
    self.titleArr = @[@"我的动态",@"交友日志",@"故事分享",@"互动问答",@"图片社",@"型男学院",@"闺蜜圈",@"版务"];
    [self.tableView registerClass:[HHYTongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)getData {
    
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getSysSocialCircleListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArray = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];

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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHYTongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.TF.placeholder = @"";
    cell.leftLB.text = self.dataArray[indexPath.row].name;
    cell.moreImgV.hidden = self.isFaTie;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isFaTie) {
        if (self.typeBlock != nil) {
            self.typeBlock(self.dataArray[indexPath.row].ID ,self.dataArray[indexPath.row].name);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }
    
}


@end
