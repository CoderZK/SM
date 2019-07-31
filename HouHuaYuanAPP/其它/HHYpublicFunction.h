//
//  HHYpublicFunction.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/6/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHYpublicFunction : NSObject
+ (CAShapeLayer *)getBezierWithFrome:(UIView * )view andRadi:(CGFloat)radi ;

+(HHYpublicFunction *)sharTool;
+ (void)updateLatitudeAndLongitude;
@end

NS_ASSUME_NONNULL_END
