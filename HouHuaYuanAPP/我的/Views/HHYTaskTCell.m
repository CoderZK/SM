//
//  HHYTaskTCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYTaskTCell.h"

@implementation HHYTaskTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hitClickButton.layer.cornerRadius = 22.5;
    self.hitClickButton.clipsToBounds = YES;
}

- (void)setModel:(HHYTongYongModel *)model {
    _model = model;
    self.titleLB.text = [NSString stringWithFormat:@"任务: %@",model.name];
    if (model.status == 1) {
        [self.hitClickButton setTitle:@"未完成" forState:UIControlStateNormal];
        [self.hitClickButton setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    }else if (model.status == 2) {
        [self.hitClickButton setTitle:@"领取奖励" forState:UIControlStateNormal];
        [self.hitClickButton setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    }else if (model.status == 3) {
        [self.hitClickButton setTitle:@"已领取" forState:UIControlStateNormal];
        [self.hitClickButton setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    }
    
    self.contentLB.text = [NSString stringWithFormat:@"奖励: +%@",model.reward];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
