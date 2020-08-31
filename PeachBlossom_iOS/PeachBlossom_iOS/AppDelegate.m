//
//  AppDelegate.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldResignOnTouchOutside = YES;
    
    [self _entrance];
    return YES;
}

- (void)_entrance {

    
    self.mainVC = [[MainTabBarController alloc]init];
    self.window.rootViewController=self.mainVC;
    [self.window makeKeyAndVisible];
}
 

@end
