//
//  GGGGLaJThreeTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGLaJThreeTVC.h"
#import "GGGGLaJThreeCell.h"
@interface GGGGLaJThreeTVC ()

@end

@implementation GGGGLaJThreeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"GGGGLaJThreeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title = @"游玩记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    [self ccc];
    [self bbb];
    [self ddd];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GGGGLaJThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)bbb {
    
}

- (void)ccc {
    
}

- (void)ddd {
    
}

@end
