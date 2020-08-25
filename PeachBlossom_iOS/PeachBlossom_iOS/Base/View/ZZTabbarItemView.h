//
//  ZZTabbarItemView.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/18.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZZTabbarItemView ,TabbarButton;

@protocol TabBarDelegate <NSObject>

@optional


- (void)tabBar:(ZZTabbarItemView *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to;

-(void)tabBarDidClickPlusButton:(ZZTabbarItemView *)tabBar;

@end




@interface ZZTabbarItemView : UIView

-(void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic , weak) id<TabBarDelegate> delegate;

@property (nonatomic ,strong) TabbarButton *selectedButton;
@property (nonatomic,strong)UIButton *centerbtn;

@property(nonatomic, strong)NSString * badgeValue;


@property (nonatomic,assign)NSInteger lastIndex;

- (void)_seletedIndex:(NSInteger)index;

@end
