//
//  HHYFlowerListCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/28.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYFlowerListCell.h"

@implementation HHYFlowerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLB.textColor = CharacterBlackColor;
    self.timeLB.textColor = CharacterBackColor;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
