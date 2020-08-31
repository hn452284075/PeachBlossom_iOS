//
//  IdentifyCodeView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "IdentifyCodeView.h"

@interface IdentifyCodeView()

@property (nonatomic, strong) NSTimer *countTimer;  //倒计时
@property (nonatomic, assign) int defaultTime;  //倒计时

@end

@implementation IdentifyCodeView
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)configViewTitle:(NSString *)title subTitle:(NSString *)subtitle defaultstr:(NSString *)dstr btnTitle:(NSString *)bstring hideFlag:(BOOL)flag
{
    UILabel *lab1 = [self viewWithTag:1];
    lab1.text = title;
    
    UILabel *lab2 = [self viewWithTag:2];
    lab2.text = subtitle;
    
    UITextField *filed = [self viewWithTag:3];
    filed.layer.masksToBounds = YES;
    filed.layer.borderWidth = 1.5;
    filed.layer.cornerRadius = 12.;
    filed.layer.borderColor = kGetColor(0xf2, 0xf2, 0xf2).CGColor;
    filed.backgroundColor = kGetColor(0xf2, 0xf2, 0xf2);
    [filed addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIButton *btn1 = [self viewWithTag:4];
    btn1.userInteractionEnabled = NO;
    btn1.alpha = 0.5;
    [btn1 setTitle:bstring forState:UIControlStateNormal];
    
    UILabel *lab3 = [self viewWithTag:5];
    UIButton *btn2 = [self viewWithTag:6];
    if(flag == YES)
    {
        lab3.hidden = YES;
        btn2.hidden = YES;
    }
    else
    {
        btn2.userInteractionEnabled = NO;
        self.defaultTime = 60;
        self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [self.countTimer fire];
    }
}

- (void)timerAction:(id)sender
{
    NSString *str = [NSString stringWithFormat:@"%d秒后可重发",self.defaultTime];
    UIButton *btn = [self viewWithTag:6];
    [btn setTitle:str forState:UIControlStateNormal];
    self.defaultTime--;
    if(self.defaultTime < 0)
    {
        [self.countTimer invalidate];
        self.countTimer = nil;
        self.defaultTime = 60;
        [btn setTitle:@"点击重发" forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
    }
    NSLog(@"timer action");
}


- (void)changedTextField:(UITextField *)sender
{
    UITextField *filed = [self viewWithTag:3];
    UIButton *btn1 = [self viewWithTag:4];
    
    if(filed.text.length > 0)
    {
        btn1.alpha = 1.;
        btn1.userInteractionEnabled = YES;
    }
    else
        btn1.alpha = 0.5;
}


- (IBAction)repeatGetCode:(id)sender
{
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.countTimer fire];
    
    UIButton *btn = [self viewWithTag:6];
    btn.userInteractionEnabled = NO;
    
    [self.delegate getCodeAgin];
}

- (IBAction)closeBtnClicked:(id)sender
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    [self.delegate disMissCodeView];
}

- (IBAction)okBtnClicked:(id)sender
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    UITextField *filed = [self viewWithTag:3];
    [self.delegate confirmCodeInfo:filed.text];
}
@end
