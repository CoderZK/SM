//
//  HHYHomeDongTaiCell.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYHomeDongTaiCell.h"

@interface HHYHomeDongTaiCell()

//@property(nonatomic,strong)UIButton *moreContentBt;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *nameLB,*contentLB,*timeLB,*desLB,*addressLB;
@property(nonatomic,strong)UIView *zanView ,* pingAndZanV,*picsView;
@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)UIView *grayV,*xiaDanV;
@property(nonatomic,strong)UIImageView *huanGuanImgV;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UIButton *ttBt;


@end

@implementation HHYHomeDongTaiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
        
        UIView * whiteV = [[UIView alloc] init];
        [self addSubview:whiteV];
        whiteV.backgroundColor = [UIColor whiteColor];
        [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.width.equalTo(@(ScreenW - 30));
            make.top.equalTo(@10);
            make.bottom.equalTo(@-10);
        }];
        self.whiteV = whiteV;
        
        self.ttBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 30 - 50 , 0, 50, 16)];
        [self.ttBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
        self.ttBt.titleLabel.font = kFont(12);
        [self.ttBt setTitle:@"置顶帖" forState:UIControlStateNormal];
        [whiteV addSubview:self.ttBt];
        
        self.deleteBt  = [[UIButton alloc] init];
        [self.deleteBt addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteBt];
        self.deleteBt.hidden = YES;
        [self.deleteBt setImage:[UIImage imageNamed:@"78"] forState:UIControlStateNormal];
        [self.deleteBt setImage:[UIImage imageNamed:@"80"] forState:UIControlStateSelected];
        [self.deleteBt mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@12);
            make.centerY.equalTo(self);
            make.height.with.equalTo(@40);
            
        }];
        
        
        whiteV.layer.shadowColor = ShadowColor.CGColor;
        // 阴影偏移，默认(0, -3)
        whiteV.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        whiteV.layer.shadowOpacity = 0.1;
        // 阴影半径，默认3
        whiteV.layer.shadowRadius = 8;
        whiteV.layer.cornerRadius = 5;
        
        
        self.backgroundColor = WhiteColor;
        //头像
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [whiteV addSubview:self.headBt];
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.headBt.tag = 100;
        //昵称
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(70, 20 , 120, 20)];
        self.nameLB.text = @"来啊";
        self.nameLB.font =[UIFont systemFontOfSize:14 weight:0.2];
        self.nameLB.textColor = CharacterBlackColor;
        [whiteV addSubview:self.nameLB];
        
        self.sexBt = [[UIButton alloc] init];
        [self.sexBt setTitle:@"19" forState:UIControlStateNormal];
        self.sexBt.titleLabel.font = kFont(10);
        [self.sexBt setBackgroundImage:[UIImage imageNamed:@"91"] forState:UIControlStateNormal];
        self.sexBt.frame = CGRectMake(70, CGRectGetMaxY(self.nameLB.frame) + 5 , 40, 15);
        
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sexBt.bounds      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight   cornerRadii:CGSizeMake(7.5, 7.5)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = self.sexBt.bounds;
//            maskLayer.path = maskPath.CGPath;
//            self.sexBt.layer.mask = maskLayer;

        
        [whiteV addSubview:self.sexBt];
        self.biaoQianOneBt = [[UIButton alloc] init];
        [whiteV addSubview:self.biaoQianOneBt];
        [self.biaoQianOneBt setTitle:@"Moon" forState:UIControlStateNormal];
        self.biaoQianOneBt.titleLabel.font = kFont(10);
        [self.biaoQianOneBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.biaoQianOneBt.backgroundColor = RGB(84, 240, 241);
         self.biaoQianOneBt.frame = CGRectMake(CGRectGetMaxX(self.sexBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 40,15);
        
        
        self.biaoQianTwoBt = [[UIButton alloc] init];
        [whiteV addSubview:self.biaoQianTwoBt];
        [self.biaoQianTwoBt setTitle:@"SP" forState:UIControlStateNormal];
        [self.biaoQianTwoBt setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        self.biaoQianTwoBt.titleLabel.font = kFont(10);
        self.biaoQianTwoBt.backgroundColor = RGB(186, 226, 110);
         self.biaoQianTwoBt.frame = CGRectMake(CGRectGetMaxX(self.biaoQianOneBt.frame) + 10, CGRectGetMinY(self.sexBt.frame) , 30, 15);
         self.biaoQianOneBt.hidden = self.biaoQianTwoBt.hidden = YES;
        
        //皇冠
        self.huanGuanImgV = [[UIImageView alloc] init];
        self.huanGuanImgV.image =[UIImage imageNamed:@"huanguan"];
        self.huanGuanImgV.size = CGSizeMake(17, 17);
        self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame);
        self.huanGuanImgV.centerY = self.nameLB.centerY;
        [whiteV addSubview:self.huanGuanImgV];

        
        //时间
        self.timeLB = [[UILabel alloc] init] ;
        self.timeLB.text = @"上海 05-06";
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = CharacterBackColor;
        [whiteV addSubview:self.timeLB];
        self.timeLB.textAlignment = NSTextAlignmentRight;
        
        [self.timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(whiteV).offset(-15);
            make.centerY.equalTo(self.nameLB.mas_centerY);
            make.left.equalTo(self.huanGuanImgV.mas_right).offset(15);
//            make.width.equalTo(@(180));
        }];
        
        self.cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 30 - 25-15, 40 , 25, 25)];
        [self.cancelBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
//        [self.cancelBt setTitle:@"" forState:UIControlStateNormal];
        [self.cancelBt setImage:[UIImage imageNamed:@"31"] forState:UIControlStateNormal];
        self.cancelBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.cancelBt.tag = 107;
        self.cancelBt.titleLabel.font = kFont(13);
        [self.cancelBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [whiteV addSubview:self.cancelBt];
//        self.cancelBt.hidden = YES;
        //内容
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 75, ScreenW -60, 20)];
        self.contentLB.numberOfLines = 3;
        self.contentLB.lineBreakMode = NSLineBreakByTruncatingHead;
        [whiteV addSubview:self.contentLB];
        
        //更多
//        self.moreContentBt = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.moreContentBt.frame = CGRectMake(ScreenW - 70 -30, CGRectGetMaxY(self.contentLB.frame) , 60, 30);
//        [self.moreContentBt setTitle:@"查看全文" forState:UIControlStateNormal];
//        [self.moreContentBt setTitleColor:CharacterRedColor forState:UIControlStateNormal];
//        self.moreContentBt.titleLabel.font = kFont(14);
////        self.moreContentBt.userInteractionEnabled = NO;
//        [self.moreContentBt sizeToFit];
//        [whiteV addSubview:self.moreContentBt];
//        [self.moreContentBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.moreContentBt.tag = 106;
        
        //图片
        self.picsView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.contentLB.frame) + 5, ScreenW - 60, 20)];
        for (int i = 0 ; i < 9 ; i ++) {
            
            UIImageView * imageView= [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.picsView addSubview:imageView];
            imageView.layer.cornerRadius = 5;
            imageView.clipsToBounds = YES;
        }
        
        [whiteV addSubview:self.picsView];
        
        
        self.desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.picsView.frame) + 10 , ScreenW - 60, 20)];
        self.desLB.text = @"女王范 实力撩 问答";
        self.desLB.font = kFont(12);
        self.desLB.textColor = CharacterBackColor;
        [whiteV addSubview:self.desLB];
        
        self.zanView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desLB.frame)+10, ScreenW-60, 40)];
        [whiteV addSubview:self.zanView];
        
        self.scanBt = [self getBt];
        [self.scanBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.scanBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.scanBt.frame = CGRectMake(15, 5, (ScreenW-60)/5, 30);
        [self.scanBt setImage:[UIImage imageNamed:@"chakan"] forState:UIControlStateNormal];
        [self.scanBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.scanBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.scanBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.zanView addSubview:self.scanBt];
        
        self.pingBt = [self getBt];
        self.pingBt.frame = CGRectMake(CGRectGetMaxX(self.scanBt.frame), 5, (ScreenW-60)/5, 30);
        [self.pingBt setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
        [self.pingBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.pingBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.pingBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.zanView addSubview:self.pingBt];
        
        
        self.zanBt = [self getBt];
        self.zanBt.frame = CGRectMake(CGRectGetMaxX(self.pingBt.frame), 5, (ScreenW-60)/5, 30);
        [self.zanBt setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [self.zanBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.zanBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.zanBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.zanView addSubview:self.zanBt];
        
        self.LikeBt = [self getBt];
        self.LikeBt.frame = CGRectMake(CGRectGetMaxX(self.zanBt.frame), 5, (ScreenW-60)/5, 30);
        [self.LikeBt setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [self.LikeBt setTitle:@"4527" forState:UIControlStateNormal];
        [self.LikeBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.LikeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.zanView addSubview:self.LikeBt];
        
        self.shareBt = [self getBt];
        self.shareBt.frame = CGRectMake(CGRectGetMaxX(self.LikeBt.frame), 5, (ScreenW-60)/5, 30);
        [self.shareBt setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self.shareBt setTitle:@"" forState:UIControlStateNormal];
        [self.shareBt setTitleColor:CharacterBackColor forState:UIControlStateNormal];
        self.shareBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.zanView addSubview:self.shareBt];
        
        
//        [self.scanBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.scanBt.tag = 101;
//        [self.pingBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.pingBt.tag = 102;
        self.scanBt.userInteractionEnabled = NO;
        self.pingBt.userInteractionEnabled = NO;
        [self.zanBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.zanBt.tag = 103;
        [self.LikeBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.LikeBt.tag = 104;
        [self.shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shareBt.tag = 105;

        
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, self.zanView.mj_h - 0.6 , ScreenW-30, 0.6)];
        backV.backgroundColor = lineBackColor;
        self.lineV = backV;
//        [self.zanView addSubview:backV];
        

        
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setIsDelete:(BOOL)isDelete {
    _isDelete = isDelete;
    self.deleteBt.hidden = !isDelete;
    if (isDelete) {
        [self.whiteV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(50));
        }];
    }else {
        [self.whiteV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(15));
        }];
    }
}

- (void)deleteAction:(UIButton *)button {
    button.selected = !button.selected;
    self.model.isSelect = button.selected;
    
}


- (void)clickAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickButtonWithCell:andIndex:)]) {
        [self.delegate didClickButtonWithCell:self andIndex:button.tag - 100];
    }
    
    
}

- (UILabel *)getLB {
    UILabel * lb = [[UILabel alloc] init];
    return lb;
}

- (UIButton *)getBt {
    UIButton * button = [[UIButton alloc] init];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    button.titleLabel.font = kFont(10);
    return button;
}


- (void)setImgViews:(NSArray *)arr {
//        arr = @[@"http://p0.qhimgs4.com/t01d406e56973481579.jpg",@"http://5b0988e595225.cdn.sohucs.com/images/20190508/a3df05de51954e2891f829380af31754.jpeg",@"http://5b0988e595225.cdn.sohucs.com/images/20190507/2e2a6a6e43304433bd7a558292fcb487.jpeg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = arr.count; i < 9; i++) {
            UIImageView * imgV = [self.picsView viewWithTag:100+i];
            
            imgV.hidden = YES;
        }
    });
    
    if (arr.count == 0 ) {
        self.picsView.mj_h = 0;
        return;
    }
    
    CGFloat space = 8;
    CGFloat ww = (ScreenW - 20 - 30 - 30) / 3;
    CGFloat hh = 0;
    for (int i = 0 ; i < arr.count; i++) {
        UIImageView * imgV = [self.picsView viewWithTag:100+i];
        imgV.hidden = NO;
        [imgV sd_setImageWithURL:[NSURL URLWithString:[HHYURLDefineTool getImgURLWithStr:arr[i]]] placeholderImage:[UIImage imageNamed:@"369"]];
        if (arr.count == 1) {
            //一张图片的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = 0;
            imgV.mj_y = 0;
            hh = ww;
            
        }else if (arr.count == 4) {
            //四张的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 2);
            imgV.y = (ww + space) * (i / 2);
            hh = CGRectGetMaxY(imgV.frame);
            
        }else {
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 3);
            imgV.y = (ww + space) * (i / 3);
            hh = CGRectGetMaxY(imgV.frame);
        }
        [imgV sd_setImageWithURL:[NSURL URLWithString:[HHYURLDefineTool getImgURLWithStr:arr[i]]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    }
    self.picsView.mj_h = hh;
    
}

- (void)setModel:(zkHomelModel *)model {
    
    _model = model;

    if (model.isTop) {
        self.ttBt.hidden = NO;
    }else {
        self.ttBt.hidden = YES;
    }
  
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[HHYURLDefineTool getImgURLWithStr:model.avatar]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.nickName;
    [self.nameLB sizeToFit];
    self.nameLB.height = 20;
    self.huanGuanImgV.mj_x = CGRectGetMaxX(self.nameLB.frame) + 10;
    if (model.isVip) {
        self.huanGuanImgV.hidden = NO;
    }else {
        self.huanGuanImgV.hidden = YES;
    }
    if (model.currentUserCollect) {
        [self.cancelBt setImage:[UIImage imageNamed:@"79"] forState:UIControlStateNormal];
    }else {
        [self.cancelBt setImage:[UIImage imageNamed:@"31"] forState:UIControlStateNormal];
    }
    
    
    self.timeLB.text = [NSString stringWithFormat:@"%@-%@ %@",model.provinceName,model.cityName,[NSString stringWithTime:model.createTime]];
    
    [self.sexBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)model.gender + 89]] forState:UIControlStateNormal];
    NSString *sexStr = [NSString stringWithFormat:@"%@ %@",[sxeArr objectAtIndex:model.gender],model.age];
    [self.sexBt setTitle:sexStr forState:UIControlStateNormal];
    self.sexBt.mj_w = 15+ [sexStr getWidhtWithFontSize:10];
    
    NSArray *  arr = [model.userTags componentsSeparatedByString:@","];
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
    
     [self.scanBt setTitle:[NSString stringWithFormat:@"%ld",model.clickNum] forState:UIControlStateNormal];
     [self.pingBt setTitle:[NSString stringWithFormat:@"%ld",model.replyNum] forState:UIControlStateNormal];
     [self.LikeBt setTitle:[NSString stringWithFormat:@"%ld",model.heat] forState:UIControlStateNormal];
     [self.zanBt setTitle:[NSString stringWithFormat:@"%ld",model.likeNum] forState:UIControlStateNormal];
    
    if (model.currentUserLike) {
        [self.zanBt setImage:[UIImage imageNamed:@"zan1"] forState:UIControlStateNormal];
    }else {
        [self.zanBt setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    }
    
    
    
  
    
    NSString * str = model.content;
    CGFloat hh = [@"谁" getSizeWithMaxSize:CGSizeMake(100, 100) withFontSize:14].height;
    
    CGFloat ch= [str getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 60];

    if (ch > hh * 3 + 3*2) {
        ch = hh * 3 + 3*2;
        self.contentLB.height = ch;
        NSString * str2 = [NSString stringWithFormat:@"%@查看原文",str];
        self.contentLB.attributedText = [str2 getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor textColorTwo:CharacterRedColor nsrange:NSMakeRange(str2.length - 4, 4)];
    }else {
        self.contentLB.height = ch;
        self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor];
    }

     self.picsView.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10 ;
    if (self.isDetail) {
         self.contentLB.height = ch;
         self.picsView.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10 ;
    }
    if (model.pic.length == 0) {
        [self setImgViews:@[]];
    }else {
       [self setImgViews:[model.pic componentsSeparatedByString:@","]];
    }
    
    if (self.isDelete) {
        self.deleteBt.selected = model.isSelect;
    }

    
//    self.desLB.text = [model.tagName stringByReplacingOccurrencesOfString:@"," withString:@"  "];
    
    self.desLB.text = model.circleName;
    
    self.desLB.mj_y = CGRectGetMaxY(self.picsView.frame) + 10;
    self.zanView.mj_y = CGRectGetMaxY(self.desLB.frame) + 0;
    
    model.cellHeight = CGRectGetMaxY(self.zanView.frame) + 20;
    
}

- (void)tapInView:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    NSArray * arr = [self.model.pic componentsSeparatedByString:@","];
    NSMutableArray * picArr = @[].mutableCopy;
    for (NSString * str  in arr) {
        [picArr addObject:[NSString stringWithFormat:@"%@",[HHYURLDefineTool getImgURLWithStr:str]]];
    }
    
    [[zkPhotoShowVC alloc] initWithArray:picArr index:tag];
    
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
