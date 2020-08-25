//
//  NSDictionary+null.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/9/5.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (null)
+(NSDictionary *)nullDic:(NSDictionary *)myDic;



//将NSDictionary中的Null类型的项目转化成@""

+(NSArray *)nullArr:(NSArray *)myArr;


//将NSString类型的原路返回

+(NSString *)stringToString:(NSString *)string;




//将Null类型的项目转化成@""

+(NSString *)nullToString;




#pragma mark - 公有方法

//类型识别:将所有的NSNull类型转化成@""

+(id)changeType:(id)myObj;


@end
