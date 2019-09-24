//
//  HHYHomeThreeCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYHomeThreeCell.h"

@interface HHYHomeThreeCell()
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIButton *centerBt;
@property(nonatomic,strong)UIButton *hitClickButton;
@property(nonatomic,strong)UIView *leftV,*centerV,*rightV;
@end


@implementation HHYHomeThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, 40)];
        self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.leftBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.leftBt setTitle:@"热门" forState:UIControlStateNormal];
        [self.leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.leftBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        self.leftBt.titleLabel.font = kFont(15);
        
//        self.leftV = [[UIView alloc] initWithFrame:CGRectMake(38, 10, 15, 15)];
//        self.leftV.backgroundColor = RGB(250, 105, 178);
//        self.leftV.alpha = 0.5;
//        self.leftV.clipsToBounds = YES;
//        self.leftV.layer.cornerRadius = 7.5;
//        self.leftV.layer.shadowColor = ShadowColor.CGColor;
//        self.leftV.layer.shadowOffset = CGSizeMake(0, 0);
//        self.leftV.layer.shadowOpacity = 0.1;//不透明度
//        self.leftV.layer.shadowRadius = 10.0;
//        [self.leftBt addSubview:self.leftV];
        
        [self addSubview:self.leftBt];
        self.leftBt.tag = 0;
        [self.leftBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake(15 +  55, 0, 50, 40)];
        self.centerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.centerBt.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.centerBt setTitle:@"最新" forState:UIControlStateNormal];
        [self.centerBt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.centerBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        self.centerBt.titleLabel.font = kFont(15);
        [self addSubview:self.centerBt];
        self.centerBt.tag = 1;
        [self.centerBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.centerV = [[UIView alloc] initWithFrame:CGRectMake(38, 10, 15, 15)];
//        self.centerV.backgroundColor = RGB(250, 105, 178);
//        self.centerV.clipsToBounds = YES;
//        self.centerV.alpha = 0.5;
//        self.centerV.layer.cornerRadius = 7.5;
//        self.centerV.layer.shadowColor = ShadowColor.CGColor;
//        self.centerV.layer.shadowOffset = CGSizeMake(0, 0);
//        self.centerV.layer.shadowOpacity = 0.1;//不透明度
//        self.centerV.layer.shadowRadius = 10.0;
//        self.centerV.hidden = YES;
//        [self.centerBt addSubview:self.centerV];
        
        
        
        self.hitClickButton = [[UIButton alloc] initWithFrame:CGRectMake(15 +  110 , 0, 50, 40)];
        self.hitClickButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.hitClickButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.hitClickButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.hitClickButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.hitClickButton setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
        self.hitClickButton.titleLabel.font = kFont(15);
        [self addSubview:self.hitClickButton];
        self.hitClickButton.tag = 2;
        [self.hitClickButton addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    self.backgroundColor =[UIColor clearColor];
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (selectIndex == 0) {
        self.leftBt.selected = self.centerV.hidden = self.rightV.hidden = YES;
        self.leftV.hidden = NO;
        self.leftBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.hitClickButton.selected =  NO;
        self.hitClickButton.titleLabel.font = kFont(15);
        
        
        
    }else if (selectIndex == 1) {
        self.centerBt.selected =self.leftV.hidden = self.rightV.hidden = YES;
        self.centerV.hidden = NO;
        self.centerBt.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
        self.hitClickButton.selected = NO;
        self.hitClickButton.titleLabel.font = kFont(15);
    }else  if (selectIndex == 2) {
        
       
    
        self.hitClickButton.selected = self.leftV.hidden = self.centerV.hidden = YES;
        self.rightV.hidden = NO;
        self.hitClickButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        self.leftBt.selected = NO;
        self.leftBt.titleLabel.font = kFont(15);
    }
    
    
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count > 0) {
        [self.leftBt setTitle:dataArray[0] forState:UIControlStateNormal];
    }
    if (dataArray.count > 1) {
        [self.centerBt setTitle:dataArray[1] forState:UIControlStateNormal];
    }
    if (dataArray.count > 2) {
        [self.hitClickButton setTitle:dataArray[2] forState:UIControlStateNormal];
    }
    
}


- (void)hitAction:(UIButton *)button {
    
    if (button.tag == 2 && ![HHYSignleTool shareTool].isLogin) {
        if (self.clickIndexBlock != nil) {
            self.clickIndexBlock(button.tag);
        }
        return;
    }
    self.selectIndex = button.tag;
    if (self.clickIndexBlock != nil) {
        self.clickIndexBlock(button.tag);
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
