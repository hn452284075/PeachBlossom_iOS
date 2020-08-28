//
//  AddToCartView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "AddToCartView.h"

@implementation AddToCartView
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)_initCartViewInfo:(UIImage *)image price:(NSString *)price msg:(NSString *)msg specArr:(NSArray *)specarr
{
    UIImageView *imgview = (UIImageView *)[self viewWithTag:1];
    imgview.image = image;
    
    UILabel *pricelab = (UILabel *)[self viewWithTag:2];
    pricelab.text = price;
    
    UILabel *msglab = (UILabel *)[self viewWithTag:3];
    msglab.text = msg;
    
    int x = 15;
    int y = 185;
    for(int i=0;i<specarr.count;i++)
    {
        UIButton *tagbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagbtn.backgroundColor = kGetColor(0xf5, 0xf5, 0xf5);
        [tagbtn setTitle:[specarr objectAtIndex:i]  forState:UIControlStateNormal];
        [self addSubview:tagbtn];        
        
        [tagbtn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
        tagbtn.layer.cornerRadius = 3.0;
        
        CGSize ze = [self sizeWithText:[specarr objectAtIndex:i] font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(200, 31)];
        
        if(x + ze.width + 50 > kScreenWidth)  //超过屏幕宽度，另起i一行
        {
            x = 15;
            y = y + 31 + 15;
        }
        
        tagbtn.frame = CGRectMake(x, y, ze.width+5, 31);
        tagbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        x +=15;
        x +=ze.width;
    }
    
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {

    NSDictionary *attrs = @{NSFontAttributeName : font};

    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}



- (IBAction)closeCartView:(id)sender
{
    [self.delegate addToCart_Cancel];
}

- (IBAction)addToCart:(id)sender
{
    [self.delegate addToCart_Ok];
}
@end
