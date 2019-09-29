//
//  GGGGLaJFourTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGLaJFourTVC.h"
#import "GGGGLaJFourCell.h"
@interface GGGGLaJFourTVC ()

@end

@implementation GGGGLaJFourTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    [self.tableView registerNib:[UINib nibWithNibName:@"GGGGLaJFourCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    
    GGGGLaJFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)ffff {
    for ( int i = 0 ; i< 100; i++) {
        int dd = arc4random() % 100;
        dd = i * dd;
        if (dd % 3 == 0) {
            NSLog(@"%d",dd);

        }
    }
}

@end
