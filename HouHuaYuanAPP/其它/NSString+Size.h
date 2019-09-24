//
//  NSString+Size.h
//  buqiuren
//
//  Created by 李晓满 on 16/9/13.
//  Copyright © 2016年 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

// 字典转json字符串方法
+(NSString *)convertToJsonDataWithDict:(id)dataDict;

+(NSString *)convertToJsonData:(NSArray *)arr;




// 电话号码验证
-(BOOL) verifyPhone;

/**
 获得字符串的大小
 */

-(CGSize)getSizeWithMaxSize:(CGSize)maxSize withFontSize:(int)fontSize;



//根据行间距 和 行的宽 字的大小计算行的高度
-(CGFloat)getWidhtWithFontSize:(int)fontSize;
- (CGFloat)getHeigtWithFontSize:(int)fontSize lineSpace:(int )lineSpace width:(CGFloat )widht;
- (CGFloat)getHeigtWithIsBlodFontSize:(int)fontSize lineSpace:(int )lineSpace width:(CGFloat )widht;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize withBlood:(BOOL)isBlood lineSpace:(int)lineSpace textColor:(UIColor *)color;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color textColorTwo:(UIColor *)colorTwo nsrange:(NSRange )range;
- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color fontTwo:(int)fontTwo nsrange:(NSRange )range;

/**
把字符串装换成日期型的格式化字符串
 */
+(NSString *)stringWithDateStrwithyymmddHHmm:(NSNumber *)str;

+(NSString *)stringWithDateStrwithshuxianyymmddHHmm:(NSNumber *)str;

/**
 *  将时间转化多少天
 */
+(NSString *)stringWithDay:(NSNumber *)str;
/**
 *  将时间转化多少天
 */
+(NSString *)stringWithTime:(NSString *)str;

/**
 把字符串装换成日期型的格式化字符串
 */
+(NSString *)stringWithDateStrwithyymmdd:(NSNumber *)str;

/** 根据时间进行判断返回时间*/
+(NSString *)stringWithDateStr:(NSString *)str;

/* MD5字符串 */
+ (NSString *)stringToMD5:(NSString *)str;

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)pinyin;

+ (NSString *)dateToOld:(NSDate *)bornDate;

+ (NSString *)getDengjiWithScroe:(NSString *)scroe;
/**
 把视频的播放时长格式化
 */
+(NSString *)stringWithVideoTime:(NSString *)video_time;


- (NSString *)getQuanUrl;

+ (NSString *)stringToMD5:(NSString *)str;


////从json转时
//+(NSString *)decodeString:(NSString*)encodedString;
//
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
