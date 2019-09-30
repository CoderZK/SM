//
//  GGGGEightLaJTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGEightLaJTVC.h"
#import "GGGGEightLaJCell.h"
#import "GGGGNineLaJTVC.h"
@interface GGGGEightLaJTVC ()

@end

@implementation GGGGEightLaJTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"baidao";
    [self.tableView registerNib:[UINib nibWithNibName:@"GGGGEightLaJCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GGGGEightLaJCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.lb1.text = @"text1";
    cell.lb2.text = @"text2";
    [cell.bt1 setTitle:@"yuyu" forState:UIControlStateNormal];
    [cell.bt2 setTitle:@"iuyt" forState:UIControlStateNormal];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GGGGNineLaJTVC * vc =[[GGGGNineLaJTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
