//
//  HHYGouWuChe.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "HHYGouWuChe.h"
#import "HHYHomeModel.h"
#import "HHYMyCarCell.h"
#import "HHYJieSuanVC.h"
@interface HHYGouWuChe ()
/**  */
@property(nonatomic , strong)NSMutableArray<HHYHomeModel *> *dataArray;
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)UILabel *allmoneyLB;
@property(nonatomic , strong)UIButton *jieSuanBt;
@property(nonatomic , assign)CGFloat allMoney;
@property(nonatomic , strong)NSMutableArray<HHYHomeModel *> *itemArr;
@end

@implementation HHYGouWuChe

-(NSMutableArray<HHYHomeModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadFromServeTTTTFFFF];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的购物车";
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYMyCarCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self createFootVggggg];
}

- (void)createFootVggggg {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 60 - sstatusHeight - 44 , ScreenW, 60)];
    self.footV.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.footV];
    
    self.allmoneyLB =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ScreenW - 20 - 80, 20)];
    self.allmoneyLB.font = kFont(14);
    self.allmoneyLB.textColor = [UIColor redColor];
    self.allmoneyLB.text =  [NSString stringWithFormat:@"总共:%@",@"0"];
    [self.footV addSubview:self.allmoneyLB];
    
    
    self.jieSuanBt =[UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBt.backgroundColor = RGB(210, 35, 39);
    self.jieSuanBt.frame = CGRectMake(ScreenW - 90, 15, 80, 30);
    [self.jieSuanBt setTitle:@"结算" forState:UIControlStateNormal];
    self.jieSuanBt.layer.cornerRadius = 4;
    self.jieSuanBt.clipsToBounds = YES;
    [self.footV addSubview:self.jieSuanBt];
    [self.jieSuanBt addTarget:self action:@selector(qiangdanActionfffff:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)qiangdanActionfffff:(UIButton *)button {
    if (self.itemArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少要选择一个商品"];
        return;
    }
    HHYJieSuanVC * vc =[[HHYJieSuanVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.itemArr = self.itemArr;
    [self.navigationController pushViewController:vc  animated:YES];
}

- (void)loadFromServeTTTTFFFF {
    NSString * sql = [NSString stringWithFormat:@"select *from kk_mygoodscar where userName = '%@' and status = 0",[HHYSignleTool shareTool].session_uid];
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    if ([db open]) {
        FMResultSet * result = [db executeQuery:sql];
        [self.dataArray removeAllObjects];
        while ([result next]) {
            
            HHYHomeModel * model = [[HHYHomeModel alloc] init];
            model.ID = [result intForColumn:@"ID"];
            model.goodId = [result stringForColumn:@"goodId"];
            model.title = [result stringForColumn:@"des"];
            model.number = [result intForColumn:@"number"];
            model.price = [result doubleForColumn:@"price"];
            [self.dataArray addObject:model];
        }
    }
    [db close];
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHYMyCarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = self.dataArray[indexPath.row].title;
    cell.contentLB.text = self.dataArray[indexPath.row].des;
    cell.moneyLB.text =  [NSString stringWithFormat:@"￥%.2f",self.dataArray[indexPath.row].price];
    if (self.dataArray[indexPath.row].isSelect) {
        [cell.bt setBackgroundImage:[UIImage imageNamed:@"kk_xuanzhong"] forState:UIControlStateNormal];
    }else {
        [cell.bt setBackgroundImage:[UIImage imageNamed:@"kk_weixuanzhong"] forState:UIControlStateNormal];
    }
    cell.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"k%@",self.dataArray[indexPath.row].goodId]];
    cell.numberLB.text =  [NSString stringWithFormat:@"数量:%ld",self.dataArray[indexPath.row].number];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.dataArray[indexPath.row].isSelect = !self.dataArray[indexPath.row].isSelect;
    [self updateFootVTwo];
    [self.tableView reloadData];
    
}

- (void)updateFootVTwo {
    CGFloat allmoey = 0;
    NSMutableArray<HHYHomeModel *> * arr = @[].mutableCopy;
    for (HHYHomeModel * model  in self.dataArray) {
        if (model.isSelect) {
            allmoey = allmoey + model.price * model.number;
            [arr addObject:model];
        }
    }
    self.allMoney = allmoey;
    self.itemArr = arr;
    self.allmoneyLB.text =  [NSString stringWithFormat:@"总价:%.2f",self.allMoney];
}

@end
