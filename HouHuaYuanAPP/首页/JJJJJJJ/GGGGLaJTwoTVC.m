//
//  GGGGLaJTwoTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGLaJTwoTVC.h"
#import "GGGGLaJTwoCell.h"
@interface GGGGLaJTwoTVC ()

@end

@implementation GGGGLaJTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GGGGLaJTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self laji];
    [self ceshiOne];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}

- (void)laji {
    NSLog(@"%@",@"你觉得呢");

}

- (void)ceshiOne {
    NSLog(@"%@",@"打印一下信息");

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
