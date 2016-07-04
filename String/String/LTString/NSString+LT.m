//
//  NSString+LT.m
//  NSStringTest
//
//  Created by Apple on 16/3/24.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import "NSString+LT.h"

@implementation NSString (LT)
/**
 *  1.返回字符串所占用的尺寸
 *
 *  @param fontSize     字体大小
 *  @param maxWidth     最大宽度
 *  @param maxHeight    最大高度
 */
- (CGSize)sizeWithFont:(CGFloat)fontSize
              maxWidth:(CGFloat)maxWidth
             maxHeight:(CGFloat)maxHeight
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}


/**
 *  2.判断自己是否为空
 *
 *  @return <#return value description#>
 */
- (BOOL) isBlank
{
    
    if (self.length == 0) {
        return YES;
    }
    
    if (self == nil || self == NULL ||(NSNull *)self == [NSNull null]) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"] || [self isEqualToString:@"null"] || [self isEqualToString:@"NULL"]) {
        return YES;
    }
    return NO;
}



/**
 *  3.自身为空的替换字符串
 *
 *  @return 是空，返回替换字符串，不是空，返回自身
 */
- (NSString *)isBlankWithChangeString:(NSString *)changeString
{
    if ([self isBlank]) {
        return changeString;
    }else {
        return self;
    }
}

/**
 *  4.是否是手机号
 *
 *  @return <#return value description#>
 */
- (BOOL)isTelNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  5.时间戳字符串,格式：format
 */
- (NSString *)stringToFormatDateString:(NSString *)format
{
    if (self.length < 10) {
        return @"";
    }
    NSString *times = [self substringToIndex:10 ];
    NSTimeInterval time=[times doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    //    @"yyyy-MM-dd"
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
/**
 *  6.时间转时间戳,YYYY年MM月dd日
 *
 *  @param NSString <#NSString description#>
 *
 *  @return <#return value description#>
 */

- (NSString *)stringTimeToTimeInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];

    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:self];
    NSString *timeSp = [NSString stringWithFormat:@"%ld000", (long)[date timeIntervalSince1970]];
    return timeSp;
}

/**
 *  7.去除字符串中的符号，如 《》 【】 [] () \n \\ \
 */
- (NSString *)stringByReplaceSymbols{
    NSString *stringReplace = self;
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"[" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"]" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"(" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@")" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@" " withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"n" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    stringReplace = [stringReplace stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    return stringReplace;
}
/**
 *  8.json字符串，转成字典
 *
 *  @return <#return value description#>
 */

- (NSDictionary *)stringJsonToDictionary{
    if ([self isBlank]) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil];
    
    return dictionary;
}
/**
 *  9.字典转json字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)dictionaryToJsonString:(NSDictionary *)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;

    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);

    for(int i = 0;i < propsCount; i++) {

        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {

            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }

    return dic;
}

+ (id)getObjectInternal:(id)obj {

    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {

        return obj;

    }
    if([obj isKindOfClass:[NSArray class]]) {

        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];

        for(int i = 0; i < objarr.count; i++) {

            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {

        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];

        for(NSString *key in objdic.allKeys) {

            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}


/**
 *  毫秒数转字符格式，TO HH:MM
 */
- (NSString *)stringToSecond
{
    if ([self isBlank]) {
        return @"";
    }
    
    if (self.integerValue<0) {
        return @"";
    }
    
    if (self.integerValue==0) {
        return @"00:00";
    }
    
    NSInteger number = self.integerValue/1000;
    NSInteger hour = number/3600;
    NSInteger min = number/60%60;
    return [NSString stringWithFormat:@"%02ld:%02ld",hour,min];
}

@end
