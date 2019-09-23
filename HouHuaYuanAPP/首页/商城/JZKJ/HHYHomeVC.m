//
//  HomeVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2018/12/8.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "HHYHomeVC.h"
#import "HHYHomeCell.h"
#import "HHYHomeModel.h"
#import "HHYGouWuChe.h"
#import "HHYGoodDetailTVC.h"
#import "HHYSearchTVC.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
@interface HHYHomeVC()<SDCycleScrollViewDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)SDCycleScrollView *sdcycView;
@property (nonatomic , strong)UIView * headView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger page;
@end


@implementation HHYHomeVC
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setHeadView];
    self.navigationItem.title = @"开学购物季";
    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYHomeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    [db open];
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(self);
        HHYSearchTVC * vc =[[HHYSearchTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES]; 
        
    }];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.tabBarController.delegate = self;
    
    FMResultSet *result = [db executeQuery:@"select * from 'kk_home' "];
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
    [self.tableView reloadData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
    
}

- (void)eewdsadrrttg{
    NSLog(@"%@",@"588dsfghnghdmj969");
    int i ;
    for (i = 0; i< 200; i++) {
        printf("4gfgbfgbn");
    }
    
}
- (void)hhhededer{
    NSLog(@"%@",@"dfhghjn");
    
}
- (void)hhheeedvcfr{
    NSLog(@"%@",@"aqewfvdfgh");
    
}
- (void)jky6gerdcf {
    NSLog(@"%@",@"rxsfsgh");
    
}

//设置头视图
- (void)setHeadView {
    self.headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /2)];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW,  ScreenW /2) delegate:self placeholderImage:nil];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.pageControlDotSize = CGSizeMake(4, 4);
    cycleScrollView.currentPageDotColor = [UIColor colorWithRed:80/255.0 green:72/255.0 blue:155/255.0 alpha:1.0];
    cycleScrollView.placeholderImage =[UIImage imageNamed:@"new_picture_default-1"];
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    self.sdcycView = cycleScrollView;
    self.sdcycView.localizationImageNamesGroup = @[[UIImage imageNamed:@"k1"],[UIImage imageNamed:@"k2"],[UIImage imageNamed:@"k3"],[UIImage imageNamed:@"k4"],[UIImage imageNamed:@"k5"],[UIImage imageNamed:@"k6"]];
    [self.headView addSubview:cycleScrollView];
    self.tableView.tableHeaderView = self.headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.page * 10 < self.dataArray.count ? self.page*10:self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHYHomeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HHYHomeModel * model = self.dataArray[indexPath.row];
    cell.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"k%ld",indexPath.row+1]];
    cell.moneyLB.text =  [NSString stringWithFormat:@"￥%.2f",model.price];
    cell.titleLB.text = model.title;
    cell.contentLB.text = model.des;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHYHomeModel * model = self.dataArray[indexPath.row];
    HHYGoodDetailTVC * vc =[[HHYGoodDetailTVC alloc] init];
    vc.index = indexPath.row;
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
