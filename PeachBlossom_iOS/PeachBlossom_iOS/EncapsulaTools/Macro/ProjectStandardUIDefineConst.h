//
//  ProjectStandardUIDefineConst.h
//  YilidiBuyer
//
//  Created by yld on 16/7/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#ifndef ProjectStandardUIDefineConst_h
#define ProjectStandardUIDefineConst_h


#define KCOLOR_Main UIColorFromRGB(0x46C67B)

 
#define KSelectedBgColor UIColorFromRGB(0xffc600)
#define KLineColor UIColorFromRGB(0xF2F2F2)
#define KViewBgColor UIColorFromRGB(0xf7f7f7)
#define KTextColor UIColorFromRGB(0x999999)
#define KWeakTextColor UIColorFromRGB(0xa9a9a9)
#define KPriceColor UIColorFromRGB(0xff3a30)
#define KSelectedTitleColor UIColorFromRGB(0xff7e00)
#define KCOLOR_MAIN_TEXT UIColorFromRGB(0x333333)
 
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//根据RGB来获取颜色
#define kGetColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//根据RGBA来获取颜色
#define kGetColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
 
//自定义字体
#define CUSTOMFONT(x)       [UIFont fontWithName:@"PingFang SC" size:x]
#define CUSTOMBOLDFONT(x)   [UIFont boldSystemFontOfSize:x]


#endif /* ProjectStandardUIDefineConst_h */
