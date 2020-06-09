//
//  HHYMineOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYMineOneCell.h"

@interface HHYMineOneCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *idLb;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgV;

@end

@implementation HHYMineOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headBt.layer.cornerRadius = 25;
    self.headBt.clipsToBounds = YES;
    self.nameLB.textColor = CharacterBlackColor;
    self.nameLB.font = [UIFont systemFontOfSize:14 weight:0.2];
    
    
}

- (void)setModel:(HHYUserModel *)model {
    _model = model;
    
    self.nameLB.text = model.nickName;
    
    if (model.gender == 1) {
        self.sexImgV.image = [UIImage imageNamed:@"nanq"];
    }else {
        self.sexImgV.image = [UIImage imageNamed:@"nvred"];
    }
    
    self.idLb.text = [NSString stringWithFormat:@"ID和邀请码: %@",model.userNo];
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[HHYURLDefineTool getImgURLWithStr:model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    if (model.authStatus.intValue == 3) {
        self.shimingImagV.hidden = NO;
    }else {
        self.shimingImagV.hidden = YES;
    }
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
