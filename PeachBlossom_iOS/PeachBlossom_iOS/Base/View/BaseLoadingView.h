//
//  BaseLoadingView.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/11/27.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseLoadingView : NSObject

+ (instancetype)sharedManager;

- (void)show;

- (void)showSuccessInfoWithStatus:(NSString*)string;

- (void)showErrorInfoWithStatus:(NSString *)string;

- (void)showSuccessInfoWithStatus:(NSString*)string disappearTimer:(double)timer;

- (void)showErrorWithStatus:(NSString *)string;

- (void)dissmiss;

@end
