//
//  UIViewController+hub.h
//  EditorWorld_ios
//
//  Created by 曾勇兵 on 2018/5/31.
//  Copyright © 2018年 曾勇兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (hub)
- (void)showHub;
- (void)showSuccessInfoWithStatus:(NSString*)string;
- (void)showSuccessInfoWithStatus:(NSString*)string disappearTimer:(double)timer;

//未showHub时直接弹出再隐藏
- (void)showErrorWithStatus:(NSString *)string;

- (void)showErrorInfoWithStatus:(NSString *)string;

- (void)dissmiss;
@end
