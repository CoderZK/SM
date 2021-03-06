//
//  HangQingVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HangQingVC.h"
#import "HHYNewsOneCell.h"
#import "HHYShowView.h"
#import "HHYNewsTwoCell.h"
#import "HHYNewFriendsTVC.h"
#import "HHYReceiveZanTVC.h"
#import "HHYAiTeMeTVC.h"
#import "HHYReceivePingLunTVC.h"
#import "HHYMineFriendsTVC.h"
#import "HHYSysMsgTVC.h"
@interface HangQingVC ()<HHYShowViewdelegate,EMContactManagerDelegate,EMChatManagerDelegate>

@property(nonatomic,strong)HHYShowView *showV;

@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<HHYTongYongModel *> *sysArr;
@property(nonatomic,strong)NSString *sysMsg;
@end

@implementation HangQingVC

- (HHYShowView *)showV {
    if (_showV == nil) {
        _showV = [[HHYShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _showV.type = 1;
        _showV.delegate = self;
    }
    return _showV;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doubleClick) name:@"doubleClick" object:nil];

    TabBarController * tvc = (TabBarController *)self.tabBarController;
    [tvc redRefresh];
    
//    [self.tableView reloadData];
    
    [self YYYYYY];
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)doubleClick {
    self.pageNo = 1;
    [self loadFromServeTTTT];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.sysArr = @[].mutableCopy;
    self.navigationItem.title = @"消息";
    [self.tableView registerClass:[HHYNewsOneCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HHYNewsTwoCell class] forCellReuseIdentifier:@"cellTwo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton * hitClickButtonn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [hitClickButtonn setBackgroundImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    [hitClickButtonn addTarget:self action:@selector(navigationItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    hitClickButtonn.tag = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hitClickButtonn];
    
    NSLog(@"%@",@"123");
   
    self.pageNo = 1;
    [self loadFromServeTTTT];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [self loadFromServeTTTT];
    }];

//    [[EMClient sharedClient].chatManager addDelegate:self  delegateQueue:nil];;
    
}


- (void)loadFromServeTTTT {
    NSMutableDictionary * dataDict = @{}.mutableCopy;
    dataDict[@"pageNo"] = @(self.pageNo);
    dataDict[@"pageSize"] = @(1000);
    [zkRequestTool networkingPOST:[HHYURLDefineTool getMyMessageListURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 0) {
            
            NSArray<HHYTongYongModel *> * arr = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"][@"chatHoldList"]];
            self.sysArr = [HHYTongYongModel mj_objectArrayWithKeyValuesArray:responseObject[@"object"][@"sysMessageList"]];
            self.sysMsg = [NSString stringWithFormat:@"%@",responseObject[@"object"][@"sysMsg"]];
            for (int i = 0 ; i < arr.count; i++) {
                EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:arr[i].friendHuanXin type:EMConversationTypeChat createIfNotExist:YES];
                
                EMMessage * lastmssage = conversation.latestMessage;
                EMMessageBodyType type = lastmssage.body.type;
                if (type == EMMessageBodyTypeImage) {
                    arr[i].chatContent = @"[图片]";
                }else if (type == EMMessageBodyTypeVoice) {
                    arr[i].chatContent = @"[语音]";
                }else if (type == EMMessageBodyTypeLocation) {
                    arr[i].chatContent = @"[位置]";
                }else if (type == EMMessageBodyTypeText){
                    arr[i].chatContent = [EaseConvertToCommonEmoticonsHelper
                                          convertToSystemEmoticons:((EMTextMessageBody *)lastmssage.body).text];
                }
                arr[i].unreadMessagesCount = conversation.unreadMessagesCount;
            }
            
            self.model = [HHYTongYongModel mj_objectWithKeyValues:responseObject[@"object"]];
            if (self.pageNo == 1) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:arr];
            self.pageNo++;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)YYYYYY {
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:self.dataArray[i].friendHuanXin type:EMConversationTypeChat createIfNotExist:YES];
        
        EMMessage * lastmssage = conversation.latestMessage;
        EMMessageBodyType type = lastmssage.body.type;
        if (type == EMMessageBodyTypeImage) {
            self.dataArray[i].chatContent = @"[图片]";
        }else if (type == EMMessageBodyTypeVoice) {
            self.dataArray[i].chatContent = @"[语音]";
        }else if (type == EMMessageBodyTypeLocation) {
            self.dataArray[i].chatContent = @"[位置]";
        }else if (type == EMMessageBodyTypeText){
            self.dataArray[i].chatContent = [EaseConvertToCommonEmoticonsHelper
                                  convertToSystemEmoticons:((EMTextMessageBody *)lastmssage.body).text];
        }
        self.dataArray[i].unreadMessagesCount = conversation.unreadMessagesCount;
        
    }
    [self.tableView reloadData];
    
}

//加好友
- (void)navigationItemButtonAction:(UIButton *)button {
    
    HHYMineFriendsTVC * vc =[[HHYMineFriendsTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 5;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)messagesDidReceive:(NSArray *)aMessages {
    
    NSLog(@"\n%@",@"123456");

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 1;
    }else if (section == 1){
        if (self.sysArr.count > 0) {
            return 1;
        }else {
            return 0;
        }
    }else {
       return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 85;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HHYNewsOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = self.model;
        __weak typeof(self) weakSelf = self;
        cell.clickIndexBlock = ^(NSInteger index) {
            if (index == 0) {
                HHYNewFriendsTVC * vc =[[HHYNewFriendsTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                self.model.FriendMsg = @"0";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (index == 1) {
                HHYReceivePingLunTVC * vc =[[HHYReceivePingLunTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                self.model.ReplyMsg = @"0";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (index ==2) {
                HHYAiTeMeTVC * vc =[[HHYAiTeMeTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.type = 0;
                self.model.AtMsg = @"0";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if (index ==3) {
                HHYAiTeMeTVC * vc =[[HHYAiTeMeTVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.type = 1;
                self.model.LikeMsg = @"0";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
        return cell;
    }else if (indexPath.section == 1) {
        HHYNewsTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
        HHYTongYongModel * model = self.sysArr[indexPath.row];
        cell.nameLB.text = @"系统消息";
        cell.contentLB.text = model.content;
        cell.timeLB.text = [NSString stringWithTime:model.createTime];
        [cell.headBt setBackgroundImage:[UIImage imageNamed:@"36"] forState:UIControlStateNormal];
        cell.typeBt.hidden = YES;
        [cell.bageBt setBadge:self.sysMsg andFont:10];
        return cell;
    } else{
        HHYNewsTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
        [cell.headBt addTarget:self action:@selector(gotoZhuYeAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.headBt.tag = indexPath.row + 100;
//        if (indexPath.row == 0) {
//            [cell.headBt setImage:[UIImage imageNamed:@"26"] forState:UIControlStateNormal];
//        }else {
//            [cell.headBt setImage:[UIImage imageNamed:@"36"] forState:UIControlStateNormal];
//        }
        HHYTongYongModel * model = self.dataArray[indexPath.row];
        model.createByAvatar = model.friendAvatar;
        cell.model = self.dataArray[indexPath.row];
        cell.nameLB.text = model.friendNickName;
        cell.contentLB.text = model.chatContent;
        cell.timeLB.text = [NSString stringWithTime:model.lastChatTime];
        cell.typeBt.hidden = YES;
       
        return cell;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 1) {
        
        HHYSysMsgTVC * vc =[[HHYSysMsgTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        self.sysMsg = @"0";
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:(UITableViewRowAnimationNone)];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 2) {
        HHYTongYongModel * model = self.dataArray[indexPath.row];
        model.unreadMessagesCount = 0;
        [self gotoCharWithOtherHuanXinID:model.friendHuanXin andOtherUserId:model.friendId andOtherNickName:model.friendNickName andOtherImg:model.friendAvatar andVC:self];
    }
    
    

}


- (void)gotoZhuYeAction:(UIButton *)button {
    HHYZhuYeTVC * vc =[[HHYZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userId = self.dataArray[button.tag - 100].friendId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return NO;
    }
    return YES;
    
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteMesgWithIndexPath:indexPath];
    }
    
}

- (void)deleteMesgWithIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.section == 1) {
        
        Weak(weakSelf);
        [self deleteMessageWithMessageId:@"0" result:^(BOOL isOK) {
            
            if (isOK) {
                [weakSelf.sysArr removeAllObjects];
                [weakSelf.tableView reloadData];
            }
            
        }];
        
    }else {
        [zkRequestTool networkingPOST:[HHYURLDefineTool deleteUserChatHoldURL] parameters:self.dataArray[indexPath.row].userChatHoldId success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([responseObject[@"code"] intValue]== 0) {
                
                [self.dataArray removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
                
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
    }
    
    
    
}


#pragma mark ------ 点击加号弹框的 选择项 ----
- (void)didClickIndex:(NSInteger )index {
    
    if (index == 0) {
        HHYMineFriendsTVC * vc =[[HHYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        self.model.FriendMsg = @"0";
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) {
        
    }else if (index == 2) {
        HHYMineFriendsTVC * vc =[[HHYMineFriendsTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = 5;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 3) {
        
    }
    
    
}

#pragma mark ------ 监听好友的回调 -------

/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    
    NSLog(@"收到好友请求%@",aUsername);

    
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    
    NSLog(@"用户B同意%@",aUsername);

    
    
}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    
      NSLog(@"用户B拒绝%@",aUsername);
}




- (void)dealloc {
    
    //移除好友回调
    [[EMClient sharedClient].contactManager removeDelegate:self];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
