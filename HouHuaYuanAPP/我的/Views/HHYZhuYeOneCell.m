//
//  HHYZhuYeOneCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/30.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYZhuYeOneCell.h"

@interface HHYZhuYeOneCell ()
@property(nonatomic,strong)UIImageView *shimingImgV;
@end

@implementation HHYZhuYeOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
   
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(15, 15 , 120, 25)];
        self.nameLB.text = @"飞鱼嫩兔";
        [self.nameLB sizeToFit];
        self.nameLB.font =[UIFont systemFontOfSize:16 weight:0.2];
        self.nameLB.textColor = CharacterBlackColor;
        [self addSubview:self.nameLB];
        
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameLB.frame) + 5, ScreenW - 45-15-15, 16)];
        self.contentLB.font = kFont(13);
        self.contentLB.textColor = CharacterBackColor;
        self.contentLB.text = @"逅花园ID: 20196330 江苏省 109.56km";
        [self addSubview:self.contentLB];
        
        
        //性别
        self.sexBt = [[UIButton alloc] init];
        [self.sexBt setTitle:@"19" forState:UIControlStateNormal];
        self.sexBt.titleLabel.font = kFont(10);
        [self addSubview:self.sexBt];
        self.biaoQianOneBt = [[UIButton alloc] init];
        [self addSubview:self.biaoQianOneBt];
        [self.biaoQianOneBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianOneBt.titleLabel.font = kFont(10);
        
        self.biaoQianTwoBt = [[UIButton alloc] init];
        [self addSubview:self.biaoQianTwoBt];
        [self.biaoQianTwoBt setTitle:@"19" forState:UIControlStateNormal];
        self.biaoQianTwoBt.titleLabel.font = kFont(10);
        self.sexBt.frame = CGRectMake(CGRectGetMaxX(self.headBt.frame) + 15 , CGRectGetMaxY(self.contentLB.frame) + 10 , 40, 15);
        self.biaoQianOneBt.frame = CGRectMake(CGRectGetMaxX(self.sexBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        self.biaoQianTwoBt.frame = CGRectMake(CGRectGetMaxX(self.biaoQianOneBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40, 15);
        [self.biaoQianOneBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.biaoQianTwoBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.sexBt.clipsToBounds = self.biaoQianTwoBt.clipsToBounds = self.biaoQianOneBt.clipsToBounds = YES;
        
        self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
        
        
        //皇冠
        self.huanGuanImgV = [[UIImageView alloc] init];
        self.huanGuanImgV.size = CGSizeMake(17, 17);
        self.huanGuanImgV.centerY = self.nameLB.centerY;
        self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame);
        self.huanGuanImgV.image =[UIImage imageNamed:@"huanguan"];
        [self addSubview:self.huanGuanImgV];
        
        self.shimingImgV = [[UIImageView alloc] init];
        self.shimingImgV.size = CGSizeMake(790.0 / 200 * 15, 15);
        self.shimingImgV.centerY = self.nameLB.centerY;
        self.shimingImgV.image  = [UIImage imageNamed:@"shiming"];
        [self addSubview:self.shimingImgV];
            
        
        //心
        self.xinImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 45-15+10, 18, 25, 25)];
        self.xinImgV.image = [UIImage imageNamed:@"79"];
        [self addSubview:self.xinImgV];
        
        //状态
        self.typeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 45-15, CGRectGetMaxY(self.xinImgV.frame) + 2, 45, 20)];
        self.typeLB.font = kFont(14);
        self.typeLB.textColor = CharacterBlackColor;
        self.typeLB.textAlignment = NSTextAlignmentRight;
        self.typeLB.text = @"已关注";
        [self addSubview:self.typeLB];
        
        self.guanZhuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 45-15 , 15 , 45, 45)];
        [self addSubview:self.guanZhuBt];
        
        

        
        
    }
    return self;
}

- (void)setUserModel:(HHYUserModel *)userModel {
    _userModel = userModel;
    
    
    self.nameLB.text = userModel.nickName;
    
    [self.nameLB sizeToFit];
    self.nameLB.height = 20;
    self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame) + 5;
    self.shimingImgV.mj_x = CGRectGetMaxX(self.huanGuanImgV.frame) +5;
    if (userModel.isVip) {
        self.huanGuanImgV.hidden = NO;
    }else {
        self.huanGuanImgV.hidden = YES;
    }
    
    if (userModel.authStatus.intValue == 3) {
        self.shimingImgV.hidden = NO;
    }else {
        self.shimingImgV.hidden = YES;
    }
    
//    if ([userModel.userId isEqualToString:[HHYSignleTool shareTool].session_uid]) {
//        self.typeLB.hidden = self.guanZhuBt.hidden = self.xinImgV.hidden = YES;
//    }else {
//        self.typeLB.hidden = self.guanZhuBt.hidden = self.xinImgV.hidden = NO;
//    }
    self.contentLB.text = [NSString stringWithFormat:@"逅花园ID %@ %@ %@",userModel.userNo,userModel.cityName,userModel.distance];
    
     self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
    
    [self.sexBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)userModel.gender + 89]] forState:UIControlStateNormal];
    NSString *sexStr = [NSString stringWithFormat:@"%@ %@",[sxeArr objectAtIndex:userModel.gender],userModel.age];
    [self.sexBt setTitle:sexStr forState:UIControlStateNormal];
    self.sexBt.mj_w = 15+ [sexStr getWidhtWithFontSize:10];
    
    NSArray *  arr = [userModel.tagsName componentsSeparatedByString:@","];
    self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
    if (arr.count > 0) {
        self.biaoQianOneBt.hidden = NO;
        [self.biaoQianOneBt setTitle:arr[0] forState:UIControlStateNormal];
        self.biaoQianOneBt.mj_w = [arr[0] getWidhtWithFontSize:10] + 20 ;
        self.biaoQianOneBt.mj_x = CGRectGetMaxX(self.sexBt.frame) + 10;
    }
    
    if (arr.count > 1) {
        self.biaoQianTwoBt.hidden = NO;
        [self.biaoQianTwoBt setTitle:arr[1] forState:UIControlStateNormal];
        self.biaoQianTwoBt.mj_w = [arr[1] getWidhtWithFontSize:10] + 20;
        self.biaoQianTwoBt.mj_x = CGRectGetMaxX(self.biaoQianOneBt.frame) + 10;
    }
    
    self.sexBt.layer.mask = [HHYpublicFunction getBezierWithFrome:self.sexBt andRadi:7.5];
    self.biaoQianOneBt.layer.mask = [HHYpublicFunction getBezierWithFrome:self.biaoQianOneBt andRadi:7.5];
    self.biaoQianTwoBt.layer.mask = [HHYpublicFunction getBezierWithFrome:self.biaoQianTwoBt andRadi:7.5];
    
}



@end
