//
//  HHYZhiDingTaoCanTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/8/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYZhiDingTaoCanTVC.h"
#import "HHYZhiDingTaoCanTVC.h"
#import "HHYTaoCanCell.h"
@interface HHYZhiDingTaoCanTVC ()
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@property(nonatomic,strong)UIButton *leftBT,*centerBt,*rightBt;
@property(nonatomic,assign)NSInteger selectIndex;
@end

@implementation HHYZhiDingTaoCanTVC

- (NSMutableArray<HHYTongYongModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = -1;
    self.navigationItem.title = @"帖子置顶套餐";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYTaoCanCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
      [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      [self getData];
    }];

    self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH - 50);
    if (sstatusHeight> 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH - 50 - 34);
    }
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 50 -sstatusHeight - 44, ScreenW, 50)];
//    self.footView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.footView];
    
    self.leftBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW / 3 , 50)];
    [self.leftBT setTitle:@"账户花朵支付" forState:UIControlStateNormal];
    self.leftBT.titleLabel.font = kFont(14);
    [self.leftBT setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.leftBT.tag = 0;
    [self.leftBT addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.leftBT];
    
    self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 3, 0, ScreenW / 3 , 50)];
    [self.centerBt setTitle:@"微信" forState:UIControlStateNormal];
    self.centerBt.titleLabel.font = kFont(14);
    [self.centerBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.centerBt.tag = 1;
    [self.centerBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.centerBt];
    
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 3 *2, 0, ScreenW / 3 , 50)];
    [self.rightBt setTitle:@"支付宝" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = kFont(14);
    [self.rightBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.rightBt.tag = 2;
    [self.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.rightBt];
    
    
}


- (void)action:(UIButton *)button {
    if  (self.selectIndex == -1) {
        [SVProgressHUD showErrorWithStatus:@"请选择套餐"];
        return;
    }
    
    if (button.tag == 0) {
        [self flawerAction];
    }else if (button.tag == 1) {
        
    }else {
        
    }
    
    
    
}

- (void)flawerAction {
    
    [SVProgressHUD show];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"payType"] = @"2";
    dict[@"pkgId"] = self.dataArray[self.selectIndex].pkgId;
    dict[@"postId"] = self.postID;
    [zkRequestTool networkingPOST:[HHYURLDefineTool postTopURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 0) {
        
            [self.navigationController popViewControllerAnimated:YES];
        
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];

    }];
    
}



- (void)getData {
    
    [SVProgressHUD show];

    [zkRequestTool networkingPOST:[HHYURLDefineTool getPostTopPkgListURL] parameters:@"" success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 0) {
          
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.dataArray = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
                [self.tableView reloadData];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
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
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHYTaoCanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = [NSString stringWithFormat:@"%@ : %@天",self.dataArray[indexPath.row].name,self.dataArray[indexPath.row].expireDays];
    cell.contentLB.text = [NSString stringWithFormat:@"费用 花朵:%@ 或 ￥:%@",self.dataArray[indexPath.row].costFlower,self.dataArray[indexPath.row].price];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == self.selectIndex) {
        cell.imgV.image = [UIImage imageNamed:@"80"];
    }else {
        cell.imgV.image = [UIImage imageNamed:@"78"];
    }
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath.row;
    [self.tableView reloadData];
    
}

@end
