//
//  HHYUserModel.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/17.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "HHYUserModel.h"

@implementation HHYUserModel

- (void)setPostInfoVoList:(NSArray *)postInfoVoList {
    _postInfoVoList = [zkHomelModel mj_objectArrayWithKeyValuesArray:postInfoVoList];
}

@end
