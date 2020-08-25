//
//  MainTabBarController.h
//  EditorWorld_ios
//
//  Created by 曾勇兵 on 2018/6/4.
//  Copyright © 2018年 曾勇兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>

/**
 *  从外部设置index
 */
- (void)didSelectItemWithIndex:(NSInteger)index;

- (void)showOrHideTabBar:(BOOL)isShow;

@end
