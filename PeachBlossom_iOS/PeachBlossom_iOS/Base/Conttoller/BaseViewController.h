//
//  BaseViewController.h
//  Huiyun_iOS
//
//  Created by 曾勇兵 on 2020/7/2.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobeMaco.h"
#import "UIViewController+hub.h"
#import "NSDictionary+null.h"
#import "AlertViewManager.h"
#import "UIView+BlockGesture.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
typedef void (^ReloadDataBlock)(BOOL isNetwork);
typedef void (^HXLoginBlock)(BOOL isLogin);
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
/**
 *  统一设置界面UI，如颜色,字体，圆角等
 */
- (void)setUIAppearance;
/**
 *  统一绑定UI数据及逻辑判断
 *  控制器处理错误
 *  @param error 错误信息
 */
- (void)errorHandle:(NSError *)error;

@property (nonatomic,assign)CGFloat placeholderViewHeight;

@property (nonatomic,assign)BOOL doNotNeedBaseBackItem;

@property (nonatomic,assign)BOOL showNavbarBottomLine;

@property (nonatomic,copy)NSString *pageTitle;

@property (nonatomic,copy)NSDictionary *requestParam;

@property (nonatomic,copy)NSDictionary *infoDic;

@property (nonatomic,assign)BOOL isPushPage;
@property (nonatomic,strong)ReloadDataBlock reloadDataBlock;
@property (nonatomic,strong)HXLoginBlock hxisLoginBlock;
//检查是否有网
- (void)_checkNetWork:(ReloadDataBlock)reloadBlock;
- (void)_jumpLoginPage;
- (void)goBack;
- (void)goBackAfter:(NSInteger)seconds;
- (void)delayGoBack;
 

 

- (void)showAlertWithTitle:(NSString *)alertTitle
                   message:(NSString *)alertMessage
                 sureTitle:(NSString *)sureTitle
               cancelTitle:(NSString *)cancelTitle
                sureAction:(AlertViewAction)sureAction
              cancelAction:(AlertViewOtherAction)cancelAction;

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction
                    cancelAction:(AlertViewOtherAction)cancelAction;

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction;

- (void)navigatePushViewController:(UIViewController *)viewController
                           animate:(BOOL)animate;

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                       sureTitle:(NSString *)sureTitle
                      sureAction:(AlertViewAction)sureAction;

@end

