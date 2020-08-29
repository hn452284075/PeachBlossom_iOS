//
//  AddToCartView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "AddToCartView.h"

@interface AddToCartView()

@property (nonatomic, assign) int selectedIndex;

@end

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
    self.selectedIndex = 0;
    
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
        tagbtn.tag = 10+i;
        
        CGSize ze = [self sizeWithText:[specarr objectAtIndex:i] font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(200, 31)];
        
        if(x + ze.width + 50 > kScreenWidth)  //超过屏幕宽度，另起i一行
        {
            x = 15;
            y = y + 31 + 15;
        }
        
        tagbtn.frame = CGRectMake(x, y, ze.width+12, 31);
        tagbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        x +=15;
        x +=ze.width;
        
        [tagbtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0)
        {
            [tagbtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}


- (void)tagBtnClicked:(id)sender
{
    for(UIView *v in self.subviews)
    {
        if([v isKindOfClass:[UIButton class]] && v.tag!= 100 && v.tag != 101)
        {
            UIButton *btn = (UIButton *)v;
            btn.layer.borderWidth = 0;
            [btn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
            btn.backgroundColor = kGetColor(0xf5, 0xf5, 0xf5);
        }
    }
    
    UIButton *btn = (UIButton *)sender;
    btn.layer.borderColor = kGetColor(0x47, 0xc6, 0x7c).CGColor;
    [btn setTitleColor:kGetColor(0x47, 0xc6, 0x7c) forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.;
    btn.backgroundColor = [UIColor clearColor];
    self.selectedIndex = (int)btn.tag - 10;
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
    [self.delegate addToCart_Ok:self.selectedIndex];
}
@end
