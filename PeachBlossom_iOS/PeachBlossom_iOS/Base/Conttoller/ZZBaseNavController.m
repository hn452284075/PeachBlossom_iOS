//
//  ZZBaseNavController.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/18.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ZZBaseNavController.h"

@interface ZZBaseNavController ()

@end

@implementation ZZBaseNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //    self.navigationBar.barTintColor = COMMONTOPICCOLOR;
    //    self.navigationBar.barTintColor = UIColorFromRGB(0xFFFFFF);
    
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height-0.5, kScreenWidth, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self.navigationBar addSubview:lineView];
//    NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithCapacity:0];
//    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:11];
//    [self.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.navigationBar.barTintColor = COMMONTOPICCOLOR;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//设置白色
//-(UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
//    NSLog(@"vcCount:%ld",self.viewControllers.count);
}

@end
