//
//  UIViewController+hub.m
//  EditorWorld_ios
//
//  Created by 曾勇兵 on 2018/5/31.
//  Copyright © 2018年 曾勇兵. All rights reserved.
//

#import "UIViewController+hub.h"
#import "BaseLoadingView.h"
@implementation UIViewController (hub)
- (void)showHub {
    
    [[BaseLoadingView sharedManager]show];
 
}


- (void)showSuccessInfoWithStatus:(NSString*)string {
    [[BaseLoadingView sharedManager]showSuccessInfoWithStatus:string];
    
}

- (void)showErrorInfoWithStatus:(NSString *)string {
    [[BaseLoadingView sharedManager]showErrorInfoWithStatus:string];
    
    
}


- (void)showSuccessInfoWithStatus:(NSString*)string disappearTimer:(double)timer{
    [[BaseLoadingView sharedManager]showSuccessInfoWithStatus:string disappearTimer:timer];
    
}
//未showHub时直接弹出再隐藏
- (void)showErrorWithStatus:(NSString *)string{
    [[BaseLoadingView sharedManager]showErrorWithStatus:string];
    
}

- (void)dissmiss {
    
    [[BaseLoadingView sharedManager]dissmiss];
    
    
    
}
@end
