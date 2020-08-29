//
//  CQSideBarManager.h
//  CQSideBarManager
//
//  Created by heartjoy on 2017/3/7.
//  Copyright © 2017年 heartjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SIDEBAR_START_POINT CGPointMake(99.f, 0.f)

#define SIDEBAR_ANIMATE_DURATION 0.25f

#define SIDEBAR_COLOR(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define SIDEBAR_RANDOM_COLOR  SIDEBAR_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1)

#define SIDEBAR_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIDEBAR_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SIDEBAR_KEY_WINDOW [UIApplication sharedApplication].keyWindow

@protocol CQSideBarManagerDelegate <NSObject>

@required

/**
 * 侧边栏里面的具体View
 */
- (UIView *)viewForSideBar;


@optional

/**
 * 点击阴影是否关闭侧边栏(默认为可关闭)
 
 */
- (BOOL)canCloseSideBar;

@end

@interface CQSideBarManager : NSObject

/**
 * 侧边栏开始显示位置(默认为(35,0))
 */
@property (nonatomic, assign) CGPoint startOffsetPoint;

+ (instancetype)sharedInstance;

/**
 * 获取侧边栏的具体view
 */
- (UIView *)viewInSideSideBar;

/**
 * 打开侧边栏
 */
- (void)openSideBar:(id<CQSideBarManagerDelegate>)delegate;

/**
 * 关闭侧边栏
 */
- (void)closeSideBar;

@end
