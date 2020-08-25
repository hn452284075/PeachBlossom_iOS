//
//  UIBarButtonItem+BarButtonItem.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (BarButtonItem)
/**
 *  根据图片快速创建一个UIBarButtonItem，返回小号barButtonItem
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 *根据图片快速创建一个UIBarButtonItem，返回大号barButtonItem
 */
+ (UIBarButtonItem *)initWithNormalImageBig:(NSString *)image target:(id)target action:(SEL)action;

/**
 *根据图片快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;


/**
 *根据文字快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(float)size  target:(id)target action:(SEL)action;

#pragma mark - 卖家项目的返回按钮
+ (UIBarButtonItem *)initDLSalerBackItemWihtAction:(SEL)action target:(id)target;

+ (UIBarButtonItem *)barButtonItemSpace:(NSInteger)itemSpace;

+ (UIBarButtonItem *)initleftItemWihtAction:(SEL)action target:(id)target;

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor AndSetButtonSize:(CGSize)btnSize titleSize:(float)size  target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
