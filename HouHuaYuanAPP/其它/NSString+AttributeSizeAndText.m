//
//  NSString+AttributeSizeAndText.m
//  HouHuaYuanAPP
//
//  Created by zk on 2019/9/24.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "NSString+AttributeSizeAndText.h"

@implementation NSString (AttributeSizeAndText)

// 字典转json字符串方法

+(NSString *)convertToJsonDataWithDict:(id)dataDict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
+ (NSString *)convertToJsonData:(NSArray *)arrarr {
    NSMutableArray * arrOne =@[].mutableCopy;
    NSMutableArray * arrTwo =@[].mutableCopy;
    return  [self convertToJsonDataWithDict:arrTwo];
}

//-(BOOL) verifyPhone
//{
//    NSString * phoneString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//
//    if (([regextestmobile evaluateWithObject:phoneString] == YES)
//        || ([regextestcm evaluateWithObject:phoneString] == YES)
//        || ([regextestct evaluateWithObject:phoneString] == YES)
//        || ([regextestcu evaluateWithObject:phoneString] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//
//}
-(CGSize)getSizeWithMaxSize:(CGSize)maxSize withFontSize:(int)fontSize
{
    CGSize size=[self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size;
}
-(CGFloat)getWidhtWithFontSize:(int)fontSize
{
    CGSize size=[self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.width;
}
- (CGFloat)getHeigtWithFontSize:(int)fontSize lineSpace:(int )lineSpace width:(CGFloat )widht {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    CGFloat height = [attributedString boundingRectWithSize:CGSizeMake(widht, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
    return height;
}

- (CGFloat)getHeigtWithIsBlodFontSize:(int)fontSize lineSpace:(int )lineSpace width:(CGFloat )widht {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    CGFloat height = [attributedString boundingRectWithSize:CGSizeMake(widht, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
    return height;
}

- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attributedString;
}



- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize withBlood:(BOOL)isBlood lineSpace:(int)lineSpace textColor:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (isBlood) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    }else {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    }
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attributedString;
}

- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color textColorTwo:(UIColor *)colorTwo nsrange:(NSRange )range {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:colorTwo range:range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attributedString;
}

- (NSMutableAttributedString *)getMutableAttributeStringWithFont:(int)fontSize lineSpace:(int)lineSpace textColor:(UIColor *)color fontTwo:(int)fontTwo nsrange:(NSRange )range {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:NSMakeRange(0, self.length - range.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontTwo] range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    return attributedString;
}


+(NSString *)stringWithDateStrwithyymmddHHmm:(NSNumber *)str
{
    long long beTime = [str longLongValue];//1000.0;
    NSString * distanceStr;
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy/MM/dd HH:mm"];
    distanceStr = [df stringFromDate:beDate];
    return distanceStr;
}

+(NSString *)stringWithDateStrwithyymmdd:(NSNumber *)str {
    long long beTime = [str longLongValue];//1000.0;
    NSString * distanceStr;
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    distanceStr = [df stringFromDate:beDate];
    return distanceStr;
}
+(NSString *)stringWithDateStrwithshuxianyymmddHHmm:(NSNumber *)str
{
    long long beTime = [str longLongValue];//1000.0;
    NSString * distanceStr;
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM月dd日 HH: mm"];
    distanceStr = [df stringFromDate:beDate];
    return distanceStr;
}

+(NSString *)stringWithDay:(NSNumber *)str
{
    NSTimeInterval beTime = [str longLongValue];//1000.0;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    [df setDateFormat:@"yyyy"];
    NSString * nowYear = [df stringFromDate:[NSDate date]];
    NSString * lastYear = [df stringFromDate:beDate];
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    if (distanceTime < 60)
    {   //小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime < 60*60)
    {   //时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime < 24*60*60 && [nowDay integerValue] == [lastDay integerValue])
    {  //时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime< 24*60*60*2 && [nowDay integerValue] != [lastDay integerValue])
    {
        if ([nowDay integerValue] - [lastDay integerValue] == 1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1))
        {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else
        {
            [df setDateFormat:@"HH:mm"];
            distanceStr = [NSString stringWithFormat:@"前天 %@",[df stringFromDate:beDate]];
        }
        
    }
    else if(distanceTime < 24*60*60*365)
    {
        if ([nowDay integerValue] - [lastDay integerValue] == 2 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1))
        {//包含前天的部分
            [df setDateFormat:@"HH:mm"];
            distanceStr = [NSString stringWithFormat:@"前天 %@",[df stringFromDate:beDate]];
        }
        else
        {
            if ([nowYear integerValue] == [lastYear integerValue])
            {//包含今年的部分
                [df setDateFormat:@"MM-dd HH:mm"];
                distanceStr = [df stringFromDate:beDate];
            }
            else
            {
                [df setDateFormat:@"yyyy-MM-dd HH:mm"];
                distanceStr = [df stringFromDate:beDate];
            }
        }
    }
    else
    {
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}


+(NSString *)stringWithTime:(NSString *)str
{
    NSTimeInterval beTime = 0;
    if (str.length > 10) {
        //以毫秒为单位 就除以1000 默认以秒为单位
        NSDateFormatter *df0 = [[NSDateFormatter alloc] init];
        if([str containsString:@"."]){
            [df0 setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        }else if([str containsString:@"-"]){
            [df0 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
        }else if([str containsString:@"/"]){
            [df0 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            
        }
        
        NSDate *date0 = [df0 dateFromString:str];
        beTime = [date0 timeIntervalSince1970];
        
    }else {
        
        beTime = [str longLongValue];
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    [df setDateFormat:@"yyyy"];
    NSString * nowYear = [df stringFromDate:[NSDate date]];
    NSString * lastYear = [df stringFromDate:beDate];
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    if (distanceTime < 60)
    {   //小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime < 60*60)
    {   //时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime < 24*60*60 && [nowDay integerValue] == [lastDay integerValue])
    {  //时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
    }
    else if(distanceTime< 24*60*60*2 && [nowDay integerValue] != [lastDay integerValue])
    {
        if ([nowDay integerValue] - [lastDay integerValue] == 1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1))
        {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else
        {
            [df setDateFormat:@"HH:mm"];
            distanceStr = [NSString stringWithFormat:@"前天 %@",[df stringFromDate:beDate]];
        }
        
    }
    else if(distanceTime < 24*60*60*365)
    {
        if ([nowDay integerValue] - [lastDay integerValue] == 2 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1))
        {//包含前天的部分
            [df setDateFormat:@"HH:mm"];
            distanceStr = [NSString stringWithFormat:@"前天 %@",[df stringFromDate:beDate]];
        }
        else
        {
            if ([nowYear integerValue] == [lastYear integerValue])
            {//包含今年的部分
                [df setDateFormat:@"MM-dd HH:mm"];
                distanceStr = [df stringFromDate:beDate];
            }
            else
            {
                [df setDateFormat:@"yyyy-MM-dd HH:mm"];
                distanceStr = [df stringFromDate:beDate];
            }
        }
    }
    else
    {
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

//根据时间判断
+(NSString *)stringWithDateStr:(NSString *)str
{
    //以毫秒为单位 就除以1000 默认以秒为单位
    long long beTime = [str longLongValue]/1000;//1000.0;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    [df setDateFormat:@"yyyy"];
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    if (distanceTime < 60)
    {   //小于一分钟
        distanceStr = @"刚刚下线";
    }
    else if (distanceTime < 60*60)
    {   //时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前在线",(long)distanceTime/60];
    }
    else if(distanceTime < 24*60*60 && [nowDay integerValue] == [lastDay integerValue])
    {  //时间小于一天
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
        distanceStr = [NSString stringWithFormat:@"%ld小时前在线",(long)distanceTime/60/60];
    }
    else
    {
        distanceStr = @"下线";
    }
    return distanceStr;
    
}

/* MD5字符串 */
+ (NSString *)stringToMD5:(NSString *)str{
    const char *fooData = [str UTF8String];//UTF-8编码字符串
    unsigned char result[CC_MD5_DIGEST_LENGTH];//字符串数组，接收MD5
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);//计算并存入数组
    NSMutableString *saveResult = [NSMutableString string];//字符串保存加密结果
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    return saveResult;
}
//汉字的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSString *)dateToOld:(NSDate *)bornDate{
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornDate];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}

+ (NSString *)getDengjiWithScroe:(NSString *)scroe{
    
    NSInteger x = [scroe integerValue];
    if (x <121) {
        return @"小种子";
    }else if (x < 251){
        return @"小嫩芽";
    }else if (x < 501){
        return @"大绿叶";
    }else if (x < 1000){
        return @"花骨朵";
    }else{
        return @"果果王";
    }
    
}

+(NSString *)stringWithVideoTime:(NSString *)video_time
{
    NSArray * arr = [video_time  componentsSeparatedByString:@"."];
    if (arr.count>0)
    {
        if (arr.count == 1) {
            arr = @[arr.firstObject,@"0"];
        }
        NSInteger m = [arr.firstObject integerValue];
        NSString *str = arr.lastObject;
        NSInteger s = [arr.lastObject integerValue]*60/10;
        if (str.length > 2) {
            s = [[arr.lastObject substringToIndex:2] integerValue]*60/10;
        }
        
        NSInteger h = m/60;
        if (h>0)
        {
            m = m%6;
            return [NSString stringWithFormat:@"%ld:%.2ld:%.2ld",(long)h,(long)m,(long)s];
        }
        else
        {
            if (m>0)
            {
                NSString * time = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)m,(long)s];
                return time;
            }
            else
            {
                return [NSString stringWithFormat:@"%lds",(long)s];
            }
        }
    }
    return @"0s";
}

//获取图片全路径
- (NSString *)getQuanUrl {
    return @"";
}


+(NSString *)decodeString:(NSString*)encodedString

{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     
                                                                                                                     CFSTR(""),
                                                                                                                     
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
    
}

+(NSString*)encodeString:(NSString*)unencodedString{
    NSString *encodedString = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}


//编码EMOJI表情字符串
- (NSString *)encodeEmojiString {
    NSMutableString *attributeString = [[NSMutableString alloc] initWithString:self];
    NSString *regex_emoji = @"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]";
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression
                               regularExpressionWithPattern:regex_emoji
                               options:NSRegularExpressionCaseInsensitive
                               error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用编码后的字符串进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:range];
        //UTF8编码
        NSString *credentialName = [NSString emojiConvert:subStr];
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
        [imageDic setObject:credentialName forKey:@"image"];
        [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
        //把字典存入数组中
        [imageArray addObject:imageDic];
    }
    //从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withString:imageArray[i][@"image"]];
    }
    return attributeString;
}

//解码EMOJI表情字符串
- (NSString *)decodeEmojiString {
    NSMutableString *attributeString = [[NSMutableString alloc] initWithString:self];
    NSString *regex_emoji = @"\\[\\[(.*?)\\]\\]";
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression
                               regularExpressionWithPattern:regex_emoji
                               options:NSRegularExpressionCaseInsensitive
                               error:&error];
    if (!re) {
        NSLog(@"[NSString toMessageString]: %@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用解码后的字符串进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [self substringWithRange:range];
        //UTF8解码
        NSString *credentialName = [NSString emojiRecovery:subStr];
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
        [imageDic setObject:credentialName forKey:@"image"];
        [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
        //把字典存入数组中
        [imageArray addObject:imageDic];
    }
    //从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withString:imageArray[i][@"image"]];
    }
    return attributeString;
}

//对emoji转码
+ (NSString *)emojiConvert:(NSString *)obj {
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet
                                          characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodeStr = [obj stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    NSString *result = [NSString stringWithFormat:@"[[%@]]", encodeStr];
    return result;
}

//对emoji解码
+ (NSString *)emojiRecovery:(NSString *)obj {
    NSString *trimBeginStr = [obj stringByReplacingOccurrencesOfString:@"[[" withString:@""];
    NSString *trimEndStr = [trimBeginStr stringByReplacingOccurrencesOfString:@"]]" withString:@""];
    NSString *decodeStr = trimEndStr.stringByRemovingPercentEncoding;
    if (decodeStr == nil || [decodeStr isEqualToString:@""]) {
        return obj;
    } else {
        return decodeStr;
    }
}



@end
