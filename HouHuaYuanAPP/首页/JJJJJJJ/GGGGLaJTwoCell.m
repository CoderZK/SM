//
//  GGGGLaJTwoCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "GGGGLaJTwoCell.h"

@implementation GGGGLaJTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    lab.text = @"hhh";
    lab.backgroundColor = [UIColor redColor];
    [self addSubview:lab];
    
    
    UIButton * bbbb = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300,  35)];
    [bbbb setTitle:@"ttt" forState:UIControlStateNormal];
    [self addSubview:bbbb];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
