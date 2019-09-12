//
//  HHYZanOrAiTeMineCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/31.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYZanOrAiTeMineCell.h"

@implementation HHYZanOrAiTeMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 25;
    self.headBt.clipsToBounds = YES;
    self.nameLB.text = @"等你来";
}

- (void)setType:(NSInteger)type {
    _type = type;
    
//    if (type == 1) {
//        NSString * str = @"赞了我的帖子: 怎么打不出去";
//        self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 7)];
//    }else {
//        NSString * str = @"@了我的帖子: 最近状态不错,假的规范和我去额日胡富国结合人工费";
//         self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 7)];
//    }
    
    
    
}

- (void)setModel:(HHYTongYongModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[HHYURLDefineTool getImgURLWithStr:model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.nickName;
 
    self.timeLB.text = [NSString stringWithTime:model.createTime];
    
    
    if (model.postContent.length == 0) {
        model.postContent = @"帖子被帖主删除";
    }
    if (self.type == 1) {
        NSString * str = [NSString stringWithFormat:@"赞了我的帖子: %@",model.postContent];
        self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 7)];
    }else {
        NSString * str = [NSString stringWithFormat:@"@了我的帖子: %@",model.postContent];
         self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor textColorTwo:[UIColor blackColor] nsrange:NSMakeRange(0, 7)];
         self.nameLB.text = model.createByNickName;
    }

    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
