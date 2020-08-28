//
//  GlobeMaco.h
//  ZCSuoPing
//
//  Created by zyb on 14-11-14.
//  Copyright (c) 2014年 掌众传媒 www.chinamobiad.com. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GlobleConst.h"
#define BoundNibView(viewNibName,ViewClass) (ViewClass *)[[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]

//2倍的imgUrl
#define TwiceImgUrlStr(imgUrlStr,width,height) [NSString stringWithFormat:@"%@_%ix%i",imgUrlStr,(int)width*2,(int)height*2]

#define kCurrentKeyWindow    [UIApplication sharedApplication].keyWindow
#define IMAGE(image)               [UIImage imageNamed:image]
#define kPageSize                  [NSNumber numberWithInteger:5]

//#define token @"token"
//#define kShopKey @"shopKey"

#define WEAK_SELF                   __weak typeof(self) weak_self = self;
#define WEAK_OBJECT(weak_obj, obj)  __weak typeof(obj) weak_obj = obj;
#define WEAK_OBJ(__obj) typeof(__obj) __weak weak_##__obj = __obj;
#define BLOCK_OBJ(__obj) typeof(__obj) __block block_##__obj = __obj;

#define kPriceFloatValueToRMB(price)  [Util toRMBValueOfFloatValue:price]




#pragma mark - ------------系统相关宏定义---------------

#define PYMargin 10 // 默认边距

#define iOS_7_Above ([[UIDevice currentDevice].systemVersion floatValue]>7.0)

#define iPhone4_width 320
#define iPhone5_width 320
#define iPhone6_width 375
#define iPhone6p_width 414

#define iPhone4_Height 480
#define iPhone5_Height 568
#define iPhone6_Height 667
#define iPhone6P_Height 736



#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480) // 320*480
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568) // 320*568
#define iPhone6 ([UIScreen mainScreen].bounds.size.height == 667) // 375*667
#define iPhone6p ([UIScreen mainScreen].bounds.size.height == 736)// 414*736
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#define iOS6 [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DeviceType (isPad?@"I2":([[UIDevice currentDevice].model rangeOfString:@"iPhone"].location !=NSNotFound?@"I1":@"I3") )
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


#define kStatusBarAndNavigationBarHeight ((iPhoneX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define kStatusBarAndTabBarHeight ((iPhoneX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)


#define APP_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height
#define APP_WIDTH [[UIScreen mainScreen] applicationFrame].size.width
 
#define kNavHeightAndTabHeight (kStatusBarAndNavigationBarHeight+kStatusBarAndTabBarHeight)
#define sysVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kNavBarAndStatusBarHeight 64
#define kTabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) 

#define SECONDS_PER_HOUR 3600
#define SECONDS_PER_MINUTE 60
// 设备状态栏
#define __StatusScreenFrame             [[UIApplication sharedApplication] statusBarFrame]
// 设备状态栏高度
#define __StatusScreen_Height           __StatusScreenFrame.size.height
#pragma mark - ------------全局常量宏定义---------------

//通知中心全局数据常量单例
#define kNotification [NSNotificationCenter defaultCenter]
//NSUserDefaults 的全局
#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define ModifyUserImage @"ModifyUserImage"

#define TailoringImage @"TailoringImage"

#define userLongitude @"longitude"

#define userInfoCacheKey  @"userInfoCacheKey"

#define deleteImageUrl @"https://app.zuzitech.com"



//#define UserIsLogin [[UserDataManager sharedManager] userIsLogin]


//UIApplication
#define kAppDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]
//按钮的圆角角度
#define m_button_cØ¡ornerRadius  4.0f
#pragma mark - ------------常用方法宏定义---------------


#define MD5(src) [src MD5Hash]
#define kSystemFontSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define IntToString(src) [NSString stringWithFormat:@"%ld", (long)src]
#define kNumberToStr(number) [NSString stringWithFormat:@"%@",number]
#define jFormat(__format, ...) [NSString stringWithFormat:__format, ##__VA_ARGS__]
#define jSetButtonNormalStateTile(button,title) [button setTitle:title forState:UIControlStateNormal]



//根据字符串长度求字符串尺寸
#define kStringSize(str,fSize,str_W,str_H) [str sizeWithFont:[UIFont systemFontOfSize:fSize] constrainedToSize:CGSizeMake(str_W, str_H)]

#define emptyBlock(block,...)  if (block) {\
block(__VA_ARGS__);\
}

static inline BOOL isEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
    
}

#ifdef DEBUG
#define JLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define JLog(FORMAT, ...) nil
#endif


