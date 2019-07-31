//
//  HHYURLDefineTool.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYURLDefineTool.h"

@implementation HHYURLDefineTool

/** 登录 */
+ (NSString * )getLoginURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/common/login"];
}
/** 广告列表 */
+ (NSString * )getBannerListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/getBannerList"];
}
/** 标签列表 */
+ (NSString * )getLabelsURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/getLabels"];
}
/** 话题列表 */
+ (NSString * )getTopicListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/getTopicList"];
}
/** 第三方登录 */
+ (NSString * )getloginAuthByThirdURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/loginAuthByThird"];
}
/**省列表*/
+ (NSString * )provinceListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/provinceList"];
}
/**市列表*/
+ (NSString * )cityListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/cityList"];
}
/** 注册 */
+ (NSString * )registerURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/register"];
}
/** 发送验证码 */
+ (NSString * )sendValidCodeURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/sendValidCode"];
}
/** 街道列表 */
+ (NSString * )streetListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/streetList"];
}
/** 上传文件 */
+ (NSString * )uploadURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/upload"];
}
/** 用户主页 */
+ (NSString * )gethomeURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/home"];
}
/** 设置标签 */
+ (NSString * )getsetMyLabelURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/setMyLabel"];
}
/** 发帖*/
+ (NSString * )getaddURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/add"];
}
/** 帖子详情 */
+ (NSString * )getdetailURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/detail"];
}
/** 社交圈子 */
+ (NSString * )getSysSocialCircleListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/getSysSocialCircleList"];
}
/** 点赞 */
+ (NSString * )getlikeURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/like"];
}
/** 评论帖子*/
+ (NSString * )getreplyURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/reply"];
}
/** 帖子列表 */
+ (NSString * )getsearchURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/search"];
}
/** 校验验证码 */
+(NSString *)validCodeURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/validCode"];
}
/** 上包地理位置 */
+(NSString *)reportLocationURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/reportLocation"];
}
/** 送花 */
+(NSString *)sendFlowers{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/sendFlowers"];
}
/** 获取隐私设置*/
+ (NSString * )getUserConfigURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getUserConfig"];
}
/** 热度榜 */
+ (NSString * )heatUserListURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/heatUserList"];
}
/** 附近的人 */
+ (NSString * )nearbyUserListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/nearbyUserList"];
}
/** 修改头像和背景图片 */
+ (NSString * )updateAvatarURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/updateAvatar"];
}
/** 换帮手机号*/
+ (NSString * )updatePhoneURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/updatePhone"];
}
/** 修改密码 */
+ (NSString * )updatePwdURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/updatePwd"];
}
/** 换绑第三方*/
+(NSString *)updateThirdAppURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/updateThirdApp"];
}
/** 隐私设置更新*/
+(NSString *)updateUserConfigURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/updateUserConfig"];
}
/** 关于我们 */
+(NSString *)aboutUsURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/aboutUs"];
}
/** 退出登录 */
+ (NSString * )getlogoutURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/logout"];
}

/** 我收到的赞列表*/
+ (NSString * )getPostLikeListForMyPostURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getPostLikeListForMyPost"];
}
/** 我收到的评论列表 */
+ (NSString * )getReplyListForMyPostURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getReplyListForMyPost"];
}
/** 我的粉丝列表 */
+ (NSString * )getMyFansUserListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyFansUserList"];
}
/** 我的详细资料 */
+ (NSString * )getMyInfoURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyInfo"];
}
/** 我的个人中心*/
+ (NSString * )getMyInfoCenterURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyInfoCenter"];
}
/** 我的订阅 */
+ (NSString * )getMySubscribeUserListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMySubscribeUserList"];
}
/** 修改我的个人资料*/
+(NSString *)updateMyInfoURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/updateMyInfo"];
}
/**  用户上传相册 */
+(NSString *)uploadPhotoURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/uploadPhoto"];
}
/** 提交反馈*/
+(NSString *)addMyFeedBackURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addMyFeedBack"];
}
/** 添加好友*/
+(NSString *)addNewFriendURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addNewFriend"];
}
/** 同意或者绝好友*/
+(NSString *)agreeNewFriendApplyURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/agreeNewFriendApply"];
}

/** 删除拉黑好友*/
+(NSString *)deleteFriendURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/deleteFriend"];
}

/** 我的反馈列表*/
+(NSString *)getMyFeedBackListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyFeedBackList"];
}
/** 好友列表*/
+(NSString *)getMyFriendUserListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyFriendUserList"];
}
/** 我的访客列表*/
+(NSString *)getMyVisitorListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyVisitorList"];
}
/** 根据id查找新朋友*/
+(NSString *)getNewFriendByUserNoURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getNewFriendByUserNo"];
}
/** 实名认证*/
+(NSString *)userAuthURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/userAuth"];
}
/**拉黑好友 我的动态点赞列表*/
+(NSString *)addUserFriendBlackURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addUserFriendBlack"];
}
/** 恢复好友*/
+(NSString *)deleteUserFriendBlackURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/deleteUserFriendBlack"];
}
/** 我的任务中心*/
+(NSString *)getMyTaskListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyTaskList"];
}
/** 我的黑名单*/
+(NSString *)getMyUserFriendBlackListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyUserFriendBlackList"];
}
/** 获取我的消息*/
+(NSString *)getMyMessageListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyMessageList"];
}

/** 提交提现申请*/
+(NSString *)addWithDrawURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/addWithDraw"];
}
/** cancelOrder*/
+(NSString *)cancelOrderURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/cancelOrder"];
}
/** closeOrder*/
+(NSString *)closeOrderURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/closeOrder"];
}
/** 我的订单列表*/
+(NSString *)getMyOrderListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/getMyOrderList"];
}
/** 订单支付*/
+(NSString *)orderPayURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/orderPay"];
}
/**订单退款*/
+(NSString *)refundOrderURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/refundOrder"];
}
/** 添加收藏*/
+(NSString *)addMyCollectionURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addMyCollection"];
}
/**  删除我的收藏*/
+(NSString *)deleteMyCollectionURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/deleteMyCollection"];
}
/** 添加我的收藏 */
+(NSString *)getMyCollectionListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyCollectionList"];
}
/** 我的消费记录*/
+(NSString *)getMyConsumeOrderListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyConsumeOrderList"];
}
/** 我的充值记录*/
+(NSString *)getMyReChargeOrderListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyReChargeOrderList"];
}
/** 我的提现列表*/
+(NSString *)getMyWithDrawListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyWithDrawList"];
}
/** 新朋友列表*/
+(NSString *)getNewFriendMsgListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getNewFriendMsgList"];
}
/** 帖子评论列表*/
+(NSString *)getReplyPageListForPostURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/getReplyPageListForPost"];
}

/**@我的消息*/
+(NSString *)getAtMeMsgListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getAtMeMsgList"];
}
///** 我的动态评论列表*/
+(NSString *)deleteMegURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/deleteMsg"];
}
/** 关注 */
+(NSString *)addUserSubscribeURL{
   return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addUserSubscribe"];
}
/** 取消订阅*/
+(NSString *)deleteUserSubscribeURL{
  return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/deleteUserSubscribe"];
}
/** 取消订阅*/
+(NSString *)getSysSocialCircleDetailURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/getSysSocialCircleDetail"];
}
/**鲜花套餐*/
+(NSString *)getHeatPkgListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/getHeatPkgList"];
}
/** vip 套餐*/
+(NSString *)getVipPkgListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/getVipPkgList"];
}
/** 上传最后一条信息*/
+(NSString *)uploadUserChatRecordURL{
    
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userChat/uploadUserChatRecord"];
    
}
/** vip 订单提交*/
+(NSString *)vipReChargeURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/vipReCharge"];
}

/** 鲜花交易记录 */
+(NSString *)getMyFlowerOrderListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyFlowerOrderList"];
}

/** 鲜花充值*/
+(NSString *)heatReChargeURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/order/heatReCharge"];
}

/** 我的动态评论列表*/
+(NSString *)addMyReportURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addMyReport"];
}
/** 添加银行卡*/
+(NSString *)addMyBankCardURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/addMyBankCard"];
}
/** 银行卡列表*/
+(NSString *)getMyBankCardListURL{
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMyBankCardList"];
}
/** 删除银行卡*/
+(NSString *)deleteMyBankCardURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/deleteMyBankCard"];
}
/** 取消点赞*/
+(NSString *)notlikeURL{
    
     return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/notlike"];
    
}

/** 删除回话*/
+(NSString *)deleteUserChatHoldURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userChat/deleteUserChatHold"];
    
}
/** 我的系统消息列表 */
+(NSString *)getMySysMsgListURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/userInfo/getMySysMsgList"];
}

/** 获取客服*/
+(NSString *)contactKefURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/common/contactKef"];
}
/** 删除帖子*/
+(NSString *)deletePostURL{
    return [NSString stringWithFormat:@"%@%@",URL,@"/api/postInfo/delete"];
}




//图片地址
+(NSString *)getImgURLWithStr:(NSString * )str{
    
    NSString * picStr = @"";
    if (str) {
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            picStr = str;
        }else{
            picStr = [NSString stringWithFormat:@"%@%@",ImgURL,str];
        }
    }
    return picStr;

}




@end
