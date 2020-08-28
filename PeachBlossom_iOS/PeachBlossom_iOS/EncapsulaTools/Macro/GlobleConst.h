//
//  GlobleConst.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/18.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#ifndef GlobleConst_h
#define GlobleConst_h



#define EncryptionKey  @"stKwxvsf*&aUOYBOprPyhp"
#define Appid  @"125802301688"

#define WxAppid         @"wx4e33a191c746afc4"
#define APP_SECRET      @"4b1ce51772f4316bcccdbb00044d7dcc"

#define kSinaAppKey     @"4001385645"
#define kRedirectURI    @"http://www.sinazuzi.com"
#define kTencentAppId   @"1108755000"


#define EaseMob_Appkey  @"1178170303178477#uxianshare"
#define EaseMobKefu_Appkey  @"1178170303178477#uxianshare"
#define Youmeng_Appkey  @"58f4306d45297d72e5001439"

#define HistoriesArray  @"HistoriesArray" // 搜索历史key

#define KNotificationWXPayResult            @"KNotificationWXPayResult"
#define KNotificationAliPayResult           @"KNotificationAliPayResult"

#define KNotificationWXShare            @"KNotificationWXShare"
#define KNotificationReleasePlayer      @"KNotificationReleasePlayer"
/**
 *  网络请求code
 */
//服务器报错
#define RequestFailedServiceErrorCode -1
//请求失败
#define RequestFailedCode 0
//请求成功
#define RequestSuccessCode 1
//未登录或登录超时
#define RequestFailedUnloginCode 2
//强制升级
#define RequestNeedForceUpdate 3


/**
 *  首页几个部分的索引
 */
#define MainPageIndex 0
#define RecommendIndex 1
#define MePageIndex 2
#define MainTabbarItemCount 5


/**
 *  请求分页参数
 */
#define kRequestPageNumKey  @"page"
#define kRequestPageSizeKey @"limit"
#define kRequestDefaultPageSize 10
#define kRequestDefaultPageNum  1

#endif /* GlobleConst_h */
