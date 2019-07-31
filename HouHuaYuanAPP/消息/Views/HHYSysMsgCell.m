//
//  HHYSysMsgCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/7/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYSysMsgCell.h"

@implementation HHYSysMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.contentLB.textColor = CharacterBlackColor;
    self.timeLB.textColor = CharacterBackColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
