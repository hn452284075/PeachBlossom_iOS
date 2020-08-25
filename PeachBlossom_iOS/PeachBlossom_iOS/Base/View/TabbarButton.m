//
//  TabbarButton.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/8/3.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "TabbarButton.h"
#import "GlobeMaco.h"

@implementation TabbarButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 不需要在用户长按的时候调整图片为灰色
        self.adjustsImageWhenHighlighted = NO;
        // 设置UIImageView的图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
        // 2.设置UILabel
        // 设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        
        [self setTitleColor:UIColorFromRGB(0x929292) forState:UIControlStateNormal];
        [self setTitleColor:KCOLOR_Main forState:UIControlStateSelected];
        [self addBadgeValue];
        
    }
    return self;
}

// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{
}

//初始化badgeValue按钮
-(void)addBadgeValue{
    // 添加数字按钮
    BadgeValueButton * badgeButton = [[BadgeValueButton alloc] init];
    // 距离右边和上边的距离是固定的
    badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:badgeButton];
    self.badgeButton = badgeButton;
}



//懒加载设置
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
    
}



#pragma mark - 覆盖父类的2个方法
#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    CGFloat titleY = image.size.height + 5;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    return CGRectMake(0, titleY, self.bounds.size.width,  titleHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    UIImage *image =  [self imageForState:UIControlStateNormal];
    return CGRectMake(0, 0, contentRect.size.width, image.size.height + 10);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    
    //设置图片
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    //设置标题
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    CGFloat badgeY = 2;
    CGFloat badgeX = self.bounds.size.width - self.badgeButton.frame.size.width - 12;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}



@end
