//
//  HHYMyCarCell.m
//  SUNWENTAOAPP
//
//  Created by kunzhang on 2018/12/19.
//  Copyright © 2018年 张坤. All rights reserved.
//

#import "HHYMyCarCell.h"

@implementation HHYMyCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addd];
    [self adddTTT];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addd {
    
    NSLog(@"%@",@"这哪好点是个一奥奇入库了规范还再");
}

- (void)adddTTT {
 
    for (int i = 0 ; i < 50; i++) {
        NSLog(@"%@",@"ariufgqeirf");

    }
    
}

@end
