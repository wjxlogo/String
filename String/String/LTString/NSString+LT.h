//
//  NSString+LT.h
//  NSStringTest
//
//  Created by Apple on 16/3/24.
//  Copyright © 2016年 wjx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface NSString (LT)
/**
 *  1.返回字符串所占用的尺寸
 *
 *  @param fontSize     字体大小
 *  @param maxWidth     最大宽度
 *  @param maxHeight    最大高度
 */
- (CGSize)sizeWithFont:(CGFloat)fontSize
              maxWidth:(CGFloat)maxWidth
             maxHeight:(CGFloat)maxHeight;




/**
 *  2.判断自己是否为空
 *
 *  @return 是空，返回YES
 */
- (BOOL) isBlank;



/**
 *  3.自身为空的替换字符串
 *
 *  @return 是空，返回替换字符串，不是空，返回自身
 */
- (NSString *)isBlankWithChangeString:(NSString *)changeString;


/**
 *  4.是否是手机号
 *
 *  @return <#return value description#>
 */
- (BOOL)isTelNum;




/**
 *  5.时间戳转字符串,格式：format
 */
- (NSString *)stringToFormatDateString:(NSString *)format;


/**
 *  6.时间转时间戳,YYYY年MM月dd日
 *
 *  @param NSString <#NSString description#>
 *
 *  @return <#return value description#>
 */

- (NSString *)stringTimeToTimeInterval;


/**
 *  7.去除字符串中的符号，如 《》 【】 [] () \n \\ \
 */
- (NSString *)stringByReplaceSymbols;

/**
 *  8.json字符串，转成字典
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)stringJsonToDictionary;
/**
 *  9.字典转json字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)dictionaryToJsonString:(NSDictionary *)dic;

/**
 *  10.对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj;
/**
 *  毫秒数转字符格式，TO HH:MM
 */
- (NSString *)stringToSecond;


@end
