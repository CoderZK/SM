//
//  GGGGLaJSevenTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGLaJSevenTVC.h"
#import "GGGGLaJSevenCell.h"
#import "GGGGEightLaJTVC.h"
@interface GGGGLaJSevenTVC ()

@end

@implementation GGGGLaJSevenTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GGGGLaJSevenCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title = @"ejifnri";
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GGGGLaJSevenCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = @"kkk";
    [cell.leftBt setTitle:@"ppp" forState:UIControlStateNormal];
    cell.contentLB.text = @"hium,oio";
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GGGGEightLaJTVC * vc =[[GGGGEightLaJTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
