//
//  HHYZhiDingTaoCanTVC.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/8/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYZhiDingTaoCanTVC.h"
#import "HHYZhiDingTaoCanTVC.h"
#import "HHYTaoCanCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
@interface HHYZhiDingTaoCanTVC ()
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@property(nonatomic,strong)UIButton *leftBT,*centerBt,*rightBt;
@property(nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)NSDictionary *payDic;
@end

@implementation HHYZhiDingTaoCanTVC

- (NSMutableArray<HHYTongYongModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXWX:) name:@"WXPAY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZFBZFB:) name:@"ZFBPAY" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = -1;
    self.navigationItem.title = @"帖子置顶套餐";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYTaoCanCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
      [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      [self getData];
    }];

    self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH - 50);
    if (sstatusHeight> 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW , ScreenH - 50 - 34);
    }
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 50 -sstatusHeight - 44, ScreenW, 50)];
//    self.footView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.footView];
    
    self.leftBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW / 3 , 50)];
    [self.leftBT setTitle:@"账户花朵支付" forState:UIControlStateNormal];
    self.leftBT.titleLabel.font = kFont(14);
    [self.leftBT setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.leftBT.tag = 0;
    [self.leftBT addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.leftBT];
    
    self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 3, 0, ScreenW / 3 , 50)];
    [self.centerBt setTitle:@"微信支付" forState:UIControlStateNormal];
    self.centerBt.titleLabel.font = kFont(14);
    [self.centerBt setImage:[UIImage imageNamed:@"zhifu_3"] forState:UIControlStateNormal];
    [self.centerBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.centerBt.tag = 1;
    [self.centerBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.centerBt];
    
    
    self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 3 *2, 0, ScreenW / 3 , 50)];
    [self.rightBt setTitle:@"支付宝支付" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font = kFont(14);
    [self.rightBt setImage:[UIImage imageNamed:@"zhifu_2"] forState:UIControlStateNormal];
    [self.rightBt setTitleColor:CharacterBlackColor forState:UIControlStateNormal];
    self.rightBt.tag = 2;
    [self.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.rightBt];
    
    
}


- (void)action:(UIButton *)button {
    if  (self.selectIndex == -1) {
        [SVProgressHUD showErrorWithStatus:@"请选择套餐"];
        return;
    }
    
    if (button.tag == 0) {
        [self flawerActionWithType:2];
    }else if (button.tag == 1) {
        [self flawerActionWithType:3];
    }else {
       [self flawerActionWithType:4];
    }
    
    
    
}

- (void)flawerActionWithType:(NSInteger)type {
    
    [SVProgressHUD show];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"payType"] = @(type);
    dict[@"pkgId"] = self.dataArray[self.selectIndex].pkgId;
    dict[@"postId"] = self.postID;

    [zkRequestTool networkingPOST:[HHYURLDefineTool postTopURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 0) {
        
            if (type == 2) {
                [SVProgressHUD showSuccessWithStatus:@"帖子置顶成功!"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.navigationController popViewControllerAnimated:YES];
                });
             
            }else if (type == 3) {
                //微信支付
                self.payDic = responseObject[@"object"];
                [self goWXpay];
                
            }else {
                //支付宝支付
                self.payDic = responseObject[@"object"];
                [self goZFB];
            }
            
        
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];

    }];
    
}



- (void)getData {
    
    [SVProgressHUD show];

    [zkRequestTool networkingPOST:[HHYURLDefineTool getPostTopPkgListURL] parameters:@"" success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 0) {
          
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.dataArray = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"]];
                [self.tableView reloadData];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHYTaoCanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = [NSString stringWithFormat:@"%@ : %@天",self.dataArray[indexPath.row].name,self.dataArray[indexPath.row].expireDays];
    cell.contentLB.text = [NSString stringWithFormat:@"费用 花朵:%@ 或 ￥:%@",self.dataArray[indexPath.row].costFlower,self.dataArray[indexPath.row].price];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == self.selectIndex) {
        cell.imgV.image = [UIImage imageNamed:@"80"];
    }else {
        cell.imgV.image = [UIImage imageNamed:@"78"];
    }
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath.row;
    [self.tableView reloadData];
    
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
    
    req.partnerId = [NSString stringWithFormat:@"%@",self.payDic[@"partnerid"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.payDic[@"prepayid"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.payDic[@"noncestr"]];
    //注意此处是int 类型
    req.timeStamp = [self.payDic[@"timestamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",self.payDic[@"package"]];
    req.sign =  [NSString stringWithFormat:@"%@",self.payDic[@"sign"]];
    
    //发起支付
    [WXApi sendReq:req];
    
}

//微信支付结果处理
- (void)WXWX:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //            zkBaoMingChengGongVC * vc =[[zkBaoMingChengGongVC alloc] init];
            //            vc.isHuoDong = YES;
            //            vc.ID = self.ID;
            //            [self.navigationController pushViewController:vc animated:YES];
            
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
    NSString *str;
    str = self.payDic[@"prepayId"];
    
    [[AlipaySDK defaultService] payOrder:self.payDic[@"prepayId"] fromScheme:@"com.houhuayuan.app" callback:^(NSDictionary *resultDic) {
        
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
            //用户取消支付
            [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
            
        } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"帖子置顶成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
         
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
        
        NSLog(@"-----------%@",resultDic);
        
        NSLog(@"==========成功");
        
        
    }];
    
    
}


//支付宝支付结果处理,此处是app 被杀死之后用的
- (void)ZFBZFB:(NSNotification *)notic {
    
    NSDictionary *resultDic = notic.object;
    
    if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
        //用户取消支付
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
        
    } else if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        [SVProgressHUD showSuccessWithStatus:@"帖子置顶成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } else {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
    NSLog(@"%@",resultDic);
    NSLog(@"成功");
    //
}



@end
