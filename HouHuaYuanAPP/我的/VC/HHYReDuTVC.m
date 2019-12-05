//
//  HHYReDuTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/5/29.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYReDuTVC.h"
#import "HHYHuaDuoOneCell.h"
#import "HHYHuaDuoFiveCell.h"
#import "HHYZhiFuCell.h"
#import "HHYFlowerListTVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface HHYReDuTVC ()<HHYHuaDuoFiveCellDelegate>
@property(nonatomic,strong)UILabel *LB1,*LB2,*LB3;
@property(nonatomic,assign)NSInteger selectIndexZhiFu;
@property(nonatomic,strong)HHYUserModel *dataModel;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@property(nonatomic,assign)NSInteger selctIndex;
@property (nonatomic,strong)NSDictionary *payDic;
@end

@implementation HHYReDuTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WWWWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBPAY:) name:@"ZFBPAY" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selctIndex = -1;
    self.dataArray = @[].mutableCopy;
    self.selectIndexZhiFu = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYHuaDuoOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HHYZhiFuCell class] forCellReuseIdentifier:@"cellZhiFu"];
    [self.tableView registerClass:[HHYHuaDuoFiveCell class] forCellReuseIdentifier:@"cellFive"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    [self initHeadV];
    [self initNav];
    
    [self loadFromServeTTTT];
    [self loadFromServeTTTTTwo];
}

- (void)loadFromServeTTTTTwo {
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[HHYURLDefineTool getMyInfoCenterURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            self.dataModel = [HHYUserModel mj_objectWithKeyValues:responseObject[@"object"]];
            self.LB2.text = [NSString stringWithFormat:@"%ld朵",self.dataModel.flowerNum];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)initNav{
    
    UIButton * leftbtn=[[UIButton alloc] initWithFrame:CGRectMake(10, sstatusHeight + 2 , 40, 40)];
    [leftbtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 10;
    [self.view addSubview:leftbtn];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    
    UIButton * hitClickButtonn=[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 60 - 15,  sstatusHeight + 2,60, 40)];
    
//    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"15"] forState:UIControlStateNormal];
    [hitClickButtonn setTitle:@"历史记录" forState:UIControlStateNormal];
    hitClickButtonn.titleLabel.font = kFont(14);
    [hitClickButtonn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    hitClickButtonn.tag = 11;
    [self.view addSubview:hitClickButtonn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hitClickButtonn];
}

- (void)initHeadV {
    UIView * headView =[[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenW, Kscale(160))];
    headView.backgroundColor  = WhiteColor;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
    imgV.image = [UIImage imageNamed:@"96"];
    [headView addSubview:imgV];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, Kscale(60), ScreenW - 30, 20)];
    lb.textColor = WhiteColor;
    lb.font = kFont(15);
    lb.text = @"鲜花";
    lb.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lb];
    self.LB1 = lb;
    
    UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(15, Kscale(60) +  20 , ScreenW - 30, 40)];
    lb2.textColor = WhiteColor;
    lb2.font = kFont(25);
    lb2.text = @"45朵";
    lb2.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lb2];
    self.LB2 = lb2;
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(15, Kscale(60) +  20 + 40 + 5  , ScreenW - 30, 20)];
    lb3.textColor = WhiteColor;
    lb3.font = kFont(14);
    lb3.text = @"(一个送花等于一朵鲜花)";
    lb3.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:lb3];
    self.LB3 = lb3;
    
    
    self.tableView.tableHeaderView = headView;
}

- (void)loadFromServeTTTT {
    
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:[HHYURLDefineTool getHeatPkgListURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            self.dataArray = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (void)didClickCell:(HHYHuaDuoFiveCell *)cell index:(NSInteger )index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    for (int i = 0 ; i < self.dataArray.count; i++) {
        if (indexPath.row * 3 + index == i) {
            self.dataArray[i].isSelect = YES;
            self.selctIndex = i;
        }else {
            self.dataArray[i].isSelect = NO;
        }
    }
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 2;
    }else if (section == 1) {
        return self.dataArray.count % 3 == 0 ? self.dataArray.count / 3 : self.dataArray.count / 3 + 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 15+20+7.5;
    }else if(indexPath.section == 1) {
    
    return 90;
    }else if (indexPath.section == 2) {
        return  15 + [@"支付须知:在支付过程中遇到任何问题\n请联系官方客服: 逅花园小姐姐" getHeigtWithFontSize:14 lineSpace:2 width:ScreenW - 30];
    }else if (indexPath.section == 3) {
        return 70;
    }
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HHYHuaDuoOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        HHYHuaDuoFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellFive" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if ((indexPath.row + 1) * 3 > self.dataArray.count) {
            cell.dataArray = [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 3 , self.dataArray.count - indexPath.row * 3)];
        }else {
            cell.dataArray =  [self.dataArray subarrayWithRange:NSMakeRange(indexPath.row * 3 , 3)];
        }
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellThree"];
        
        if (cell == nil ) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellThree"];
            NSString * str = @"支付须知:在支付过程中遇到任何问题\n请联系官方客服: 逅花园小姐姐";
            CGFloat hh = [str getHeigtWithFontSize:14 lineSpace:2 width:ScreenW - 30];
            UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5, ScreenW - 30, hh)];
            lb.numberOfLines = 0;
            lb.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:2 textColor:CharacterBackColor textColorTwo:CharacterBlack40 nsrange:NSMakeRange(str.length - 6, 6)];
            lb.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lb];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 3) {
        HHYZhiFuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellZhiFu" forIndexPath:indexPath];
        if (self.selectIndexZhiFu == indexPath.row) {
            cell.rightImgV.image = [UIImage imageNamed:@"80"];
        }else {
            cell.rightImgV.image = [UIImage imageNamed:@"78"];
        }
        if (indexPath.row == 0) {
            cell.titleLB.text = @"支付宝支付";
        }else {
           cell.titleLB.text = @"微信支付";
        }
        cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"zhifu_%ld",indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell5"];
        
        if (cell == nil ) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell5"];
            UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(15, 18+40, ScreenW - 30, 44)];
            [bt setTitle:@"确认充值" forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(chongZhiAction:) forControlEvents:UIControlEventTouchUpInside];
            [bt setBackgroundImage:[UIImage imageNamed:@"backr"] forState:UIControlStateNormal];
            bt.layer.cornerRadius = 22;
            bt.clipsToBounds = YES;
            [cell addSubview:bt];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        self.selectIndexZhiFu = indexPath.row;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void)chongZhiAction:(UIButton *)button {
    
    if (self.selctIndex == -1){
        [SVProgressHUD showErrorWithStatus:@"请选择一个套餐"];
        return;
    }
    
    
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"pkgId"] = self.dataArray[self.selctIndex].pkgId;
    if (self.selectIndexZhiFu == 0) {
        dataDict[@"payType"] = @(4);
    }else {
        dataDict[@"payType"] = @(3);
    }
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[HHYURLDefineTool heatReChargeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 0) {
            if (self.selectIndexZhiFu == 0) {
                //支付宝
                self.payDic = responseObject[@"object"];
                [self goZFB];
                
            }else {
                //微信
                self.payDic = responseObject[@"object"];
                [self goWXpay];
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)navigationItemButtonAction:(UIButton *)btn{
    
    if (btn.tag == 10) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //历史记录
        HHYFlowerListTVC * vc =[[HHYFlowerListTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
       
    }
}

#pragma mark -微信、支付宝支付
- (void)goWXpay {
    

    
    PayReq * req = [[PayReq alloc]init];

    //    /** 商家向财付通申请的商家id */
    //    @property (nonatomic, retain) NSString *partnerId;
    //    /** 预支付订单 */
    //    @property (nonatomic, retain) NSString *prepayId;
    //    /** 随机串，防重发 */
    //    @property (nonatomic, retain) NSString *nonceStr;
    //    /** 时间戳，防重发 */
    //    @property (nonatomic, assign) UInt32 timeStamp;
    //    /** 商家根据财付通文档填写的数据和签名 */
    //    @property (nonatomic, retain) NSString *package;
    //    /** 商家根据微信开放平台文档对数据做的签名 */
    //    @property (nonatomic, retain) NSString *sign;

    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerId"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayId"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"nonceStr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timeStamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",self.payDic[@"package"]];
    req.sign =  [NSString stringWithFormat:@"%@",self.payDic[@"sign"]];
    //发起支付
    [WXApi sendReq:req];
    
}

//微信支付结果处理
- (void)WWWWX:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataModel.flowerNum = self.dataModel.flowerNum + ([self.dataArray[self.selctIndex].heat integerValue] + [self.dataArray[self.selctIndex].heatGift integerValue]);
            self.LB2.text = [NSString stringWithFormat:@"%ld朵",self.dataModel.flowerNum];
        });
        
        
    }
    else if (resp.errCode==WXErrCodeUserCancel)
    {
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}



//支付宝支付结果处理
- (void)goZFB{

    
    [[AlipaySDK defaultService] payOrder:self.payDic[@"prepayId"] fromScheme:@"com.houhuayuan.app" callback:^(NSDictionary *resultDic) {
        
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            //用户取消支付
            [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
            
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dataModel.flowerNum = self.dataModel.flowerNum + ([self.dataArray[self.selctIndex].heat integerValue] + [self.dataArray[self.selctIndex].heatGift integerValue]);
                self.LB2.text = [NSString stringWithFormat:@"%ld朵",self.dataModel.flowerNum];
            });
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
        
        NSLog(@"-----------%@",resultDic);
        
        NSLog(@"==========成功");
        
        
    }];
    
    
}


//支付宝支付结果处理,此处是app 被杀死之后用的
- (void)ZFBPAY:(NSNotification *)notic {
    
    NSDictionary *resultDic = notic.object;
    
    if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
        //用户取消支付
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        
    } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataModel.flowerNum = self.dataModel.flowerNum + ([self.dataArray[self.selctIndex].heat integerValue] + [self.dataArray[self.selctIndex].heatGift integerValue]);
            self.LB2.text = [NSString stringWithFormat:@"%ld朵",self.dataModel.flowerNum];
        });
        
       
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
    NSLog(@"%@",resultDic);
    NSLog(@"成功");
    //
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
