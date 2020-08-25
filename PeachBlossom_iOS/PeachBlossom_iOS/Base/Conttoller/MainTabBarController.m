//
//  MainTabBarController.m
//  EditorWorld_ios
//
//  Created by 曾勇兵 on 2018/6/4.
//  Copyright © 2018年 曾勇兵. All rights reserved.
//

#import "MainTabBarController.h"
#import "ZZTabbarItemView.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "StoreViewController.h"
#import "BusinessCircleVC.h"
#import "ZZBaseNavController.h"
@interface MainTabBarController ()<TabBarDelegate>

@property (nonatomic, strong)ZZTabbarItemView *customTabbar;
 
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _customTabBarView];
    
    [self setUpTabBarViewController];
    
    [self.tabBar setHidden:YES];
 
    self.view.backgroundColor = [UIColor whiteColor];
}

 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTabBarViewController {
 
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self addChildViewController:homeVC title:@"首页" image:@"home-hui" selectedImage:@"home-lv"];
    StoreViewController *storeVC = [[StoreViewController alloc]init];
    [self addChildViewController:storeVC title:@"店铺" image:@"store-hui" selectedImage:@"store-lv"];
    BusinessCircleVC *circleVC = [[BusinessCircleVC alloc]init];
    [self addChildViewController:circleVC title:@"商圈" image:@"circle-hui" selectedImage:@"circle-lv"];
    MeViewController *meVC = [[MeViewController alloc]init];
    [self addChildViewController:meVC title:@"我的" image:@"my-hui" selectedImage:@"my-lv"];
    
}
- (void)_removeSytemTabbuttons {
    
    //     //1. 先将TabBarView上的子视图移除
    for (UIView *subView in self.tabBar.subviews) {
        // 反射机制
        if ([subView isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 移除视图视图
            [subView removeFromSuperview];
        }else if ([subView isMemberOfClass:NSClassFromString(@"UITabBarItem")]){
            [subView removeFromSuperview];
            
        }
    }
}

- (void)_customTabBarView
{
    //添加自定义TabBar
    if (self.customTabbar==nil) {
        self.customTabbar = [[ZZTabbarItemView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.tabBar.bounds.size.height, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height)];
        _customTabbar.delegate = self;
 
        [self.view addSubview:_customTabbar];
    }
    
    
}
#pragma mark ------------------------Init---------------------------------

#pragma mark ------------------------Private------------------------------
#pragma mark 初始化子控制器的属性
- (void)addChildViewController:(UIViewController *)child title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
 
    
    ZZBaseNavController *nav =[[ZZBaseNavController alloc] initWithRootViewController:child];
    [self addChildViewController:nav];
    
//     3.添加按钮
 
    [_customTabbar addTabBarButtonWithItem:item];
}

- (void)showOrHideTabBar:(BOOL)isShow {
    if (_customTabbar) {
        WEAK_SELF
        if (isShow == YES) {
            
            [UIView animateWithDuration:0.25f animations:^{
                weak_self.customTabbar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - weak_self.tabBar.bounds.size.height, weak_self.tabBar.bounds.size.width, weak_self.tabBar.bounds.size.height);
            }];
            weak_self.customTabbar.centerbtn.hidden = NO;
        } else {
            weak_self.customTabbar.centerbtn.hidden = YES;
            [UIView animateWithDuration:0.25f animations:^{
                weak_self.customTabbar.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth(weak_self.customTabbar.bounds), CGRectGetHeight(weak_self.customTabbar.bounds));
            }];
        }
        
    
    }
}

#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate------------------------
- (void)_jumpLoginPage {
    
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    ZZBaseNavController *loginNav = [[ZZBaseNavController alloc] initWithRootViewController:loginVC];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:NO completion:nil];
   
    
}
#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------
#pragma mark IWTabBar的代理方法
- (void)tabBar:(ZZTabbarItemView *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to
{
    
    NSInteger clickIndex = to;
    if (clickIndex==3) {
//        if (!UserIsLogin) {
//            [self _jumpLoginPage];
//            return;
//        }
    }
    self.selectedIndex = clickIndex;
}

#pragma Mark-DBTabBarDelegate
//中间发布按钮
- (void)tabBarDidClickPlusButton:(ZZTabbarItemView *)tabBar
{
    NSLog(@"点击了中间按钮");
  
    

}



- (void)didSelectItemWithIndex:(NSInteger)index
{
    
    self.selectedIndex = index - 10;
    [_customTabbar _seletedIndex:index];
}
@end
