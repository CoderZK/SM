//
//  NSString+AttributeSizeAndText.h
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (AttributeSizeAndText)
+(NSString *)convertToJsonDataWithDict:(id)dataDict;
+(NSString *)convertToJsonData:(NSArray *)arr;
-(BOOL) verifyPhone;
-(CGSize)getSizeWithMaxSize:(CGSize)maxSize withFontSize:(int)fontSize;
-(CGFloat)getWidhtWithFontSize:(int)fontSize;
- (CGFloat)getHeigtWithFontSize:(int)fontSize lineSpace:(int )lineSpace width:(CGFloat )widht;
- (CGFloat)getHeigtWithIsBlodFontSize:(int)fontSize lineSpace:(int )lineSpace width:(CGFloat )widht;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize withBlood:(BOOL)isBlood lineSpace:(int)lineSpace textColor:(UIColor *)color;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color textColorTwo:(UIColor *)colorTwo nsrange:(NSRange )range;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color fontTwo:(int)fontTwo nsrange:(NSRange )range;
+(NSString *)stringWithDateStrwithyymmddHHmm:(NSNumber *)str;
+(NSString *)stringWithDateStrwithshuxianyymmddHHmm:(NSNumber *)str;
+(NSString *)stringWithDay:(NSNumber *)str;
+(NSString *)stringWithTime:(NSString *)str;
+(NSString *)stringWithDateStrwithyymmdd:(NSNumber *)str;
+(NSString *)stringWithDateStr:(NSString *)str;
+ (NSString *)stringToMD5:(NSString *)str;
- (NSString *)pinyin;
+ (NSString *)dateToOld:(NSDate *)bornDate;
+ (NSString *)getDengjiWithScroe:(NSString *)scroe;
+(NSString *)stringWithVideoTime:(NSString *)video_time;
- (NSString *)getQuanUrl;
+ (NSString *)stringToMD5:(NSString *)str;
////从json转时
//+(NSString *)decodeString:(NSString*)encodedString;
////转json时
//+(NSString*)encodeString:(NSString*)unencodedString;
////编码EMOJI表情字符串
//- (NSString *)encodeEmojiString;
////解码EMOJI表情字符串
//- (NSString *)decodeEmojiString;
//对emoji转码
+ (NSString *)emojiConvert:(NSString *)obj;
//对emoji解码
+ (NSString *)emojiRecovery:(NSString *)obj;
@end

NS_ASSUME_NONNULL_END
