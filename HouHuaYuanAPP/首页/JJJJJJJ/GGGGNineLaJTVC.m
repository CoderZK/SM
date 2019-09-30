//
//  GGGGNineLaJTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGNineLaJTVC.h"
#import "GGGGNineLaJCell.h"
@interface GGGGNineLaJTVC ()

@end

@implementation GGGGNineLaJTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第九";
    [self.tableView registerNib:[UINib nibWithNibName:@"GGGGNineLaJCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GGGGNineLaJCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = @"left";
    [cell.rightBT setTitle:@"right" forState:UIControlStateNormal];
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
