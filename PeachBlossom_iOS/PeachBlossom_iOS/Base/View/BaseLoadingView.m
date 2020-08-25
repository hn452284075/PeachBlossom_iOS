//
//  BaseLoadingView.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/11/27.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "BaseLoadingView.h"
#import "SVProgressHUD.h"


static BaseLoadingView *_baseLoadingView = nil;
@implementation BaseLoadingView
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _baseLoadingView = [[BaseLoadingView alloc] init];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    });
    return _baseLoadingView;
}

- (void)show{
 
    [SVProgressHUD show];
   
    
}


- (void)showSuccessInfoWithStatus:(NSString*)string{
    
    [SVProgressHUD showSuccessWithStatus:string];
  
//    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    
}

 

- (void)showErrorInfoWithStatus:(NSString *)string {
  
    [SVProgressHUD showErrorWithStatus:string];
 
//    [SVProgressHUD setMinimumDismissTimeInterval:0.1];
 
}


- (void)showSuccessInfoWithStatus:(NSString*)string disappearTimer:(double)timer{
  
    [SVProgressHUD showSuccessWithStatus:string];
 
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
 
 
 
}
//未showHub时直接弹出再隐藏
- (void)showErrorWithStatus:(NSString *)string{
 
    [SVProgressHUD showErrorWithStatus:string];
    [SVProgressHUD setMinimumDismissTimeInterval:0.1];
 
 
 
}

- (void)dissmiss {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [SVProgressHUD dismiss];
 
    });
    
 

}
@end
