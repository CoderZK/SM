//
//  HHYAddressTVC.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/12.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "HHYAddressTVC.h"
#import "HHYAddAddressVC.h"
#import "HHYAddressCell.h"

@interface HHYAddressTVC ()
/**  */
@property(nonatomic , strong)NSMutableArray<HHYHomeModel *> *dataArray;
@end

@implementation HHYAddressTVC
-(NSMutableArray<HHYHomeModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [button setTitle:@"新增" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(xinZengAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYAddressCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 1000;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataBBBBB];
}
- (void)getDataBBBBB {
 
    FMDatabase * db =[FMDBSingle shareFMDB].fd;
    NSString * sql = [NSString stringWithFormat:@"select * from kk_address"];
    BOOL isOpen =[db open];
    if (isOpen) {
        FMResultSet *result =[db executeQuery:sql];
        while ([result next]) {
            HHYHomeModel * model = [[HHYHomeModel alloc] init];
            model.phone = [result stringForColumn:@"phone"];
            model.name = [result stringForColumn:@"name"];
            model.address = [result stringForColumn:@"address"];
            [self.dataArray addObject:model];
        }
       
    }else {
        [SVProgressHUD showErrorWithStatus:@"数据异常"];
    }
    
    [db close];
    [self.tableView reloadData];
}


-(void)xinZengAction {
    
    HHYAddAddressVC * vc = [[HHYAddAddressVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc  animated:YES];
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHYAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HHYHomeModel * model = self.dataArray[indexPath.row];
    cell.titleLB.text =  [NSString stringWithFormat:@"姓名:%@  %@,",model.name,model.phone];
    cell.contentLB.text =  [NSString stringWithFormat:@"%@",model.address];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.sendAddressBlock != nil) {
        self.sendAddressBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
