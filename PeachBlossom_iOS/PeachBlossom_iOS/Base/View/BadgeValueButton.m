//
//  BadgeValueButton.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/8/3.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "BadgeValueButton.h"

@implementation BadgeValueButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[self resizeImageWithName:@"main_badge"] forState:UIControlStateNormal];
    }
    return self;
}


//懒加载设置badgeValue
-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            //获取文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

-(UIImage *)resizeImageWithName:(NSString *)name
{
    UIImage * image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
