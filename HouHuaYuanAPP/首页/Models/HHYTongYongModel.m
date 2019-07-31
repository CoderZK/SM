//
//  HHYTongYongModel.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/13.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYTongYongModel.h"

@implementation HHYTongYongModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id",@"AtMsg":@"newAtMsg",@"FriendMsg":@"newFriendMsg",@"LikeMsg":@"newLikeMsg",@"ReplyMsg":@"newReplyMsg",@"msgId":@"userMsgId",@"userContent":@"targetContent"};
}

- (void)setContent:(NSString *)content {
    _content = [NSString emojiRecovery:content];
}

- (void)setTargetContent:(NSString *)targetContent {
    _targetContent = [NSString emojiRecovery:targetContent];
}

- (void)setUserContent:(NSString *)userContent {
    _userContent = [NSString emojiRecovery:userContent];
}

@end
