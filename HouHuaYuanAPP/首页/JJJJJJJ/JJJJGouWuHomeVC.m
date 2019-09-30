//
//  JJJJGouWuHomeVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "JJJJGouWuHomeVC.h"
#import "JJJJGouWuHomeCell.h"
#import "JJJJDetailTVC.h"

#import "GGGGLaJOneTVC.h"
#import "GGGGLaJTwoTVC.h"
#import "GGGGLaJThreeTVC.h"
#import "GGGGLaJFourTVC.h"
#import "GGGGLaJFiveTVC.h"
#import "GGGGLaJSixTVC.h"
#import "GGGGLaJSevenTVC.h"

@interface JJJJGouWuHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *leftTV,*rightTV;
@property(nonatomic,strong)NSArray *leftDataArr;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger leftIndex;
@end

@implementation JJJJGouWuHomeVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageSize = 1;
    self.leftIndex = 0;
    self.navigationItem.title = @"购物商城";
    
    self.leftTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, ScreenH)];
    self.leftTV.dataSource = self;
    self.leftTV.delegate = self;
    [self.view addSubview:self.leftTV];
    
    self.rightTV = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, ScreenW - 80 , ScreenH - sstatusHeight - 44)];
    self.rightTV.dataSource = self;
    self.rightTV.delegate = self;
    [self.view addSubview:self.rightTV];
    
    [self.rightTV registerNib:[UINib nibWithNibName:@"JJJJGouWuHomeCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    [self.leftTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.leftDataArr = @[@"全部",@"生活",@"学生",@"送人",@"其它"];
    [self.leftTV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionNone)];
    [self getDataWithIndex:0];
    self.rightTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageSize = 1;
        [self.dataArray removeAllObjects];
        [self getDataWithIndex:self.leftIndex];
    }];
    self.rightTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [SVProgressHUD show];
        self.pageSize++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.rightTV.mj_footer endRefreshing];
            [self.rightTV reloadData];
            [SVProgressHUD dismiss];
        });
        
    }];
    
}


- (void)getDataWithIndex:(NSInteger )index {
    
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    [db open];
    NSString * sql = @"select * from 'kk_home' ";
    if (index> 0) {
        sql = [NSString stringWithFormat:@"select * from 'kk_home' where goodsID = '%ld'",(long)index];
    }
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) {
        HHYHomeModel *person = [HHYHomeModel new];
        person.ID = [result intForColumn:@"ID"];
        person.desTwo = [result stringForColumn:@"desTwo"];
        person.title = [result stringForColumn:@"title"];
        person.img = [result stringForColumn:@"img"];
        person.des = [result stringForColumn:@"des"];
        person.price =[result doubleForColumn:@"price"];
        [self.dataArray addObject:person];
    }
    [db close];
    [self.rightTV.mj_header endRefreshing];
    [self.rightTV.mj_footer endRefreshing];

    [self.rightTV reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTV) {
        return self.leftDataArr.count;
    }
    return self.dataArray.count > self.pageSize * 10 ? self.pageSize * 10 : self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTV) {
        return 45;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTV) {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = self.leftDataArr[indexPath.row];
        cell.textLabel.textColor = CharacterBlack40;
        return cell;
    }
    JJJJGouWuHomeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
    HHYHomeModel * model = self.dataArray[indexPath.row];
    cell.imgV.image = [UIImage imageNamed:model.img];
    cell.titelLB.text = model.des;
    cell.priceLB.text = [NSString stringWithFormat:@"￥%0.2f",model.price];
    cell.textLabel.textColor = CharacterBlack40;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rightTV) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        HHYHomeModel * model = self.dataArray[indexPath.row];
        JJJJDetailTVC * vc =[[JJJJDetailTVC alloc] init];
        vc.model = model;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self.dataArray removeAllObjects];
        self.pageSize = 1;
        self.leftIndex = indexPath.row;
        [self getDataWithIndex:indexPath.row];
    }
    
    
}

- (void)pushFive {
    GGGGLaJFiveTVC * vc =[[GGGGLaJFiveTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushFour {
    GGGGLaJFourTVC * vc =[[GGGGLaJFourTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushThree {
    GGGGLaJThreeTVC * vc =[[GGGGLaJThreeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushTwo {
    GGGGLaJTwoTVC * vc =[[GGGGLaJTwoTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushOne {
    GGGGLaJOneTVC * vc =[[GGGGLaJOneTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushSix {
    GGGGLaJSixTVC * vc =[[GGGGLaJSixTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushSeven {
    GGGGLaJSevenTVC * vc =[[GGGGLaJSevenTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushALl {
    
    [self pushOne];
    [self pushTwo];
    [self pushThree];
    [self pushFour];
    [self pushFive];
    [self pushSix];
    [self pushSeven];
    
}

@end
