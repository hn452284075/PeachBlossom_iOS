//
//  NSString+Add.h
//  BloodSugar-Patient
//
//  Created by 吴清林 on 2020/7/1.
//  Copyright © 2020 wangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Add)

/*
 计算字符串的CGSize
 */
- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/*
 计算字符串高度
 */
- (CGFloat)getStringHeightWithFont:(UIFont *)font viewWidth:(CGFloat)width;

/*
 手机号隐藏中间四位
 */
- (NSString *)numberSuitScanf;

/*
 去掉空格
 */
- (NSString *)deleteBlank;

/*
 去掉空格及空行
 */
- (NSString *)deleteBlankAndEnter;

/*
 判断邮箱格式是否正确
 */
- (BOOL)validateEmail;

/*
 千分位格式化数据
 */
- (NSString *)ittemThousandPointsFromNumString;

/*判断手机号码格式是否正确*/
- (BOOL)valiMobile;

/*
 获取10位时间戳
 */
+ (NSString *)getNow10Time;

/*
 获取13位时间戳
 */
+ (NSString *)getNow13Time;

/*
 13位时间戳格式化时间**yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)timerFormat:(NSString *)format dateTimer:(NSString *)timeStampString;

/// 判断字符串是否为空。否：返回空字符串
/// @param string 字符串
+ (NSString *)isEmptyForString:(NSString *)string;

/// 判断字符串是否为空。否：返回字符串0
/// @param string 字符串
+ (NSString *)isEmptyForIntegerStr:(NSString *)string;

/// 判断字符串是否为空。否：返回NSInteger 0
/// @param string 字符串
+ (NSInteger )isEmptyForInteger:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
