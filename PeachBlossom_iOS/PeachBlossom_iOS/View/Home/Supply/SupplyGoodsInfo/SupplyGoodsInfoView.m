//
//  SupplyGoodsInfoView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SupplyGoodsInfoView.h"

@implementation SupplyGoodsInfoView
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)_initGoodsTitleInfo:(NSString *)title price:(NSString *)price weight:(NSString *)weight distance:(NSString *)distance see:(NSString *)see
{
    UILabel *lab1 = [self viewWithTag:1];
    lab1.text = title;
    
    UILabel *lab2 = [self viewWithTag:2];
    lab2.text = price;
    
    UIButton *btn3 = [self viewWithTag:3];
    [btn3 setTitle:weight forState:UIControlStateNormal];
    
    UILabel *lab4 = [self viewWithTag:4];
    lab4.text = distance;
    
    UILabel *lab5 = [self viewWithTag:5];
    lab5.text = see;
}

- (IBAction)supplyShareBtnClicked:(id)sender
{
    [self.delegate supply_share_Action];
}

- (IBAction)supplyLoveBtnClciked:(id)sender
{
    [self.delegate supply_love_Action];
}



@end
