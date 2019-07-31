//
//  HHYQunSettingTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYQunSettingTVC.h"
#import "HHYTongYongCell.h"
#import "HHYMineFriendsCell.h"
@interface HHYQunSettingTVC ()
@property(nonatomic,strong)UIView *headView,*footView;
@end

@implementation HHYQunSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"群设置";
    
    [self.tableView registerClass:[HHYTongYongCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HHYMineFriendsCell class] forCellReuseIdentifier:@"cellTwo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initHeadVAndFootV];
}

- (void)initHeadVAndFootV {
    
    
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    [self initHread];
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    self.footView.backgroundColor = [UIColor clearColor];
    
    UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, ScreenW- 40, 45)];
    deleteBt.layer.cornerRadius = 4;
    deleteBt.clipsToBounds = YES;
    [deleteBt setTitle:@"删除并退出" forState:UIControlStateNormal];
    [deleteBt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
    [deleteBt addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:deleteBt];
    self.tableView.tableFooterView = self.footView;
    
    
    
    
    
}

- (void)initHread {
    NSArray * arr = @[@"hhh",@"日服"];
    CGFloat ww = 60;
    CGFloat space = (ScreenW - 4*ww - 30) / 3;
    [self.headView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0 ; i< arr.count + 2; i++) {
        
        HHYQunHeadView * v = [[HHYQunHeadView alloc] initWithFrame:CGRectMake(15 + (i % 4) * (ww + space),i/4 * (ww + 25 + 15) + 15  , ww, ww+25)];
        if (i < arr.count) {
            v.titleLB.text = arr[i];
        }else if (i == arr.count){
            
            [v.headBt setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
            
        }else if (i == arr.count + 1) {
            
             [v.headBt setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
            self.headView.mj_h = CGRectGetMaxY(v.frame)+15;
            self.tableView.tableHeaderView = self.headView;
        }
        [self.headView addSubview:v];
        v.headBt.tag = 100+i;
        [v.headBt addTarget:self action:@selector(headAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

//点击头像
- (void)headAction:(UIButton *)button {
    
}

//点击退出
- (void)deleteAction:(UIButton *)button {
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 95;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HHYMineFriendsCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
        cell.clipsToBounds = YES;
        cell.guanZhuBt.hidden = cell.typeLB.hidden =  cell.xinImgV.hidden = YES;
        return cell;
    }else {
        HHYTongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.swith.hidden = YES;
        cell.TF.placeholder = @"";
        if(indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.leftLB.text = @"全部成员";
                
            }else {
                cell.leftLB.text = @"群名称";
                cell.TF.text = @"anger,aeofru";
            }
            
            
        }else if (indexPath.section == 2) {
            if (indexPath.row == 2) {
                cell.swith.hidden = YES;
                cell.leftLB.text = @"清除聊天记录";
            }else {
                if (indexPath.row == 0) {
                    cell.leftLB.text = @"消息免打扰";
                }else {
                    cell.leftLB.text = @"消息置顶";
                }
                cell.swith.hidden = NO;
            }
            
            
        }
        return cell;
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end




@implementation HHYQunHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.headBt.layer.cornerRadius = 30;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, frame.size.width, 20)];
        self.titleLB.font = kFont(13);
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.textColor = CharacterBlack40;
        self.titleLB.text = @"";
        [self addSubview:self.titleLB];
        
        
    }
    return self;
}

@end
