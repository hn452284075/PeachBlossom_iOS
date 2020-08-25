//
//  NSString+Add.m
//  BloodSugar-Patient
//
//  Created by 吴清林 on 2020/7/1.
//  Copyright © 2020 wangyan. All rights reserved.
//

#import "NSString+Add.h"

@implementation NSString (Add)
/*
 计算字符串的CGSize
 */
- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}
/*
 计算字符串高度
 */
- (CGFloat)getStringHeightWithFont:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // 计算文字占据的高度
    CGSize size = [self boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    return  size.height;
}

/*
 手机号隐藏中间四位
 */
- (NSString *)numberSuitScanf {
    //首先验证是不是手机号码
    NSString *MOBILE = @"^(1[3-9]+\\d{9})?$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isOk = [regextestmobile evaluateWithObject:self];
    if (isOk) {
        //如果是手机号码的话
        NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }
    return self;
}

/*
 去掉空格
 */
- (NSString *)deleteBlank {
    NSString *newString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newString;
}

/*
 去掉空格及空行
 */
- (NSString *)deleteBlankAndEnter {
    NSString *newString= [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString= [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return newString;
}

/*
 判断邮箱格式是否正确
 */
- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*
 千分位格式化数据
 */
- (NSString *)ittemThousandPointsFromNumString {
    NSString *str = self;
    
    NSString *preStr = @"";
    if ([str rangeOfString:@"-"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        preStr = @"-";
    }
    
    NSString *lastStr = @"";
    if ([str rangeOfString:@"."].location != NSNotFound) {
        NSArray *array = [str componentsSeparatedByString:@"."];
        if (array.count > 1) {
            str = array[0];
            lastStr = [NSString stringWithFormat:@".%@",array[1]];
        }
    }
    
    NSUInteger len = [str length];
    NSUInteger x = len % 3;
    NSUInteger y = len / 3;
    NSUInteger dotNumber = y;
    
    if (x == 0) {
        dotNumber -= 1;
        x = 3;
    }
    NSMutableString *rs = [@"" mutableCopy];
    
    [rs appendString:[str substringWithRange:NSMakeRange(0, x)]];
    
    for (int i = 0; i < dotNumber; i++) {
        [rs appendString:@","];
        [rs appendString:[str substringWithRange:NSMakeRange(x + i * 3, 3)]];
    }
    rs = [NSMutableString stringWithFormat:@"%@%@",preStr,rs];
    [rs appendString:lastStr];
    return rs;
}

/*判断手机号码格式是否正确*/
- (BOOL)valiMobile {
    if (self.length == 0) {
        return NO;
    }
    NSString * mobile = self;
    mobile = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *first = [self substringToIndex:1];//字符串开始
    
    BOOL judgeMobile = NO;
    
    if (mobile.length == 11 && [first isEqualToString:@"1"]) {
        judgeMobile = YES;
    }
    else {
        judgeMobile = NO;
    }
    return judgeMobile;
}
/*
 获取10位时间戳
 */
+ (NSString *)getNow10Time {
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];//@"1517468580"
    return timeSp;
}

/*
 获取13位时间戳
 */
+ (NSString *)getNow13Time {
    //获取当前时间戳
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", time];
    return timeSp;
}

/*
 13位时间戳格式化时间**yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)timerFormat:(NSString *)format dateTimer:(NSString *)timeStampString {
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (NSString *)isEmptyForString:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]] || !string) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@", string];
}

+ (NSString *)isEmptyForIntegerStr:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]] || !string) {
        return @"0";
    }
    return [NSString stringWithFormat:@"%@", string];
}

+ (NSInteger)isEmptyForInteger:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]] || !string) {
        return 0;
    }
    return [string integerValue];
}

@end
