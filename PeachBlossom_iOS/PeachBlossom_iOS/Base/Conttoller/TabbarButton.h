//
//  TabbarButton.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/8/3.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeValueButton.h"
@interface TabbarButton : UIButton

@property (nonatomic,strong) UITabBarItem *item;

@property(nonatomic, weak) BadgeValueButton * badgeButton;

@end
