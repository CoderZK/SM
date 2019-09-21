//
//  HHYSearchTVC.m
//  SUNWENTAOAPP
//
//  Created by zk on 2019/1/7.
//  Copyright © 2019年 张坤. All rights reserved.
//

#import "HHYSearchTVC.h"
#import "HHYHomeCell.h"
#import "HHYHomeModel.h"
#import "HHYGoodDetailTVC.h"
@interface HHYSearchTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITextField *TF;
@end

@implementation HHYSearchTVC
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYHomeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navigationItem.title = @"搜索";
    
    UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    headV.backgroundColor = WhiteColor;
    self.tableView.tableHeaderView = headV;
    self.TF =[[UITextField alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 30)];
    self.TF.returnKeyType = UIReturnKeySearch;
    self.TF.placeholder = @"请输入你要查询的内容";
    self.TF.font = kFont(14);
    self.TF.delegate = self;
    [headV addSubview:self.TF];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"搜索内容不能为空"];
        return NO;
    }else {
        
        [self searchAction];
        return YES;
    }
    
    
    
}


- (void)searchAction {
    FMDatabase * db = [FMDBSingle shareFMDB].fd;
    [db open];
    NSString * sql = [NSString stringWithFormat:@"select * from 'HHY_home' where title like '%%%@%%'",self.TF.text];
    FMResultSet *result = [db executeQuery:sql];
    [self.dataArray removeAllObjects];
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
    if (self.dataArray.count == 0) {
        [SVProgressHUD showSuccessWithStatus:@"暂无此类型的商品"];
    }else {
        [self.TF resignFirstResponder];
    }
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HHYHomeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HHYHomeModel * model = self.dataArray[indexPath.row];
    cell.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"k%ld",model.ID]];
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
