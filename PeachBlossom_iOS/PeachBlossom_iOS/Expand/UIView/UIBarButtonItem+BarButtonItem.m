//
//  UIBarButtonItem+BarButtonItem.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "UIBarButtonItem+BarButtonItem.h"

@implementation UIBarButtonItem (BarButtonItem)
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage imageNamed:image];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 30, 12, 22);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+ (UIBarButtonItem *)initWithNormalImageBig:(NSString *)image target:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenHeight-35, 30, 35, 35);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, height);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(float)size  target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor AndSetButtonSize:(CGSize)btnSize titleSize:(float)size  target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, btnSize.width, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

#pragma mark - 靖港项目的返回按钮
+ (UIBarButtonItem *)initDLSalerBackItemWihtAction:(SEL)action target:(id)target{

    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(0, 22, 25, 50)];
    [button_na setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button_na addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button_na];
    
}



+ (UIBarButtonItem *)barButtonItemSpace:(NSInteger)itemSpace {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (!itemSpace) {
        itemSpace = -12;
    }
    negativeSpacer.width = itemSpace;
    return negativeSpacer;
}
@end
