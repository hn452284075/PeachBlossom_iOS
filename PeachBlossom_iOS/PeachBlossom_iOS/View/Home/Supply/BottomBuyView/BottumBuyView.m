//
//  BottumBuyView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "BottumBuyView.h"

@implementation BottumBuyView
@synthesize delegate;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        int size = 20;
        int x = 25;
        int gap = (kScreenWidth/2-x*2-size*3)/2;
        
        UIImageView *chatImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, 10, size, size)];
        chatImg.image = IMAGE(@"supply_chat");
        [self addSubview:chatImg];
        
        UIImageView *callImg = [[UIImageView alloc] initWithFrame:CGRectMake(x+size+gap, 10, size, size)];
        callImg.image = IMAGE(@"supply_call");
        [self addSubview:callImg];
        
        UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(x+2*(size+gap), 10, size, size)];
        carImg.image = IMAGE(@"supply_car");
        [self addSubview:carImg];
        
        UIButton *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size*2, size*1.5)];
        [self addSubview:chatBtn];
        [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(chatImg.mas_centerX);
            make.top.equalTo(chatImg.mas_bottom).offset(-6);
        }];
        [chatBtn setTitle:@"聊一聊" forState:UIControlStateNormal];
        chatBtn.titleLabel.font = CUSTOMFONT(12);
        [chatBtn setTitleColor:kGetColor(0x9a, 0x9a, 0x9a) forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(chatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
       
        
        UIButton *callBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size*2, size*1.5)];
        [self addSubview:callBtn];
        [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(callImg.mas_centerX);
            make.top.equalTo(callImg.mas_bottom).offset(-6);
        }];
        [callBtn setTitle:@"打电话" forState:UIControlStateNormal];
        callBtn.titleLabel.font = CUSTOMFONT(12);
        [callBtn setTitleColor:kGetColor(0x9a, 0x9a, 0x9a) forState:UIControlStateNormal];
        [callBtn addTarget:self action:@selector(callBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIButton *carBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size*2, size*1.5)];
        [self addSubview:carBtn];
        [carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(carImg.mas_centerX);
            make.top.equalTo(carImg.mas_bottom).offset(-6);
        }];
        [carBtn setTitle:@"购物车" forState:UIControlStateNormal];
        carBtn.titleLabel.font = CUSTOMFONT(12);
        [carBtn setTitleColor:kGetColor(0x9a, 0x9a, 0x9a) forState:UIControlStateNormal];
        [carBtn addTarget:self action:@selector(carBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *carSubBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
        [self addSubview:carSubBtn];
        [carSubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(carImg.mas_left).offset(13);
            make.top.equalTo(carImg.mas_top).offset(-4);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
        }];
        [carSubBtn setTitle:@"10" forState:UIControlStateNormal];
        carSubBtn.titleLabel.font = CUSTOMFONT(9);
        [carSubBtn setTitleColor:kGetColor(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        carSubBtn.backgroundColor = kGetColor(0xff, 0x48, 0x06);
        carSubBtn.layer.cornerRadius = 7;
                
        UIButton *addBtn = [[UIButton alloc] init];
        [self addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(0);
            make.top.equalTo(self.mas_top).offset(8);
            make.height.mas_equalTo(42);
            make.width.mas_equalTo((kScreenWidth/2-15)/2);
        }];
        [addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        addBtn.titleLabel.font = CUSTOMFONT(16);
        [addBtn setTitleColor:kGetColor(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        addBtn.backgroundColor = [UIColor orangeColor];
        [addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *buyBtn = [[UIButton alloc] init];
        [self addSubview:buyBtn];
        [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(8);
            make.height.mas_equalTo(42);
            make.width.mas_equalTo((kScreenWidth/2-15)/2);
        }];
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        buyBtn.titleLabel.font = CUSTOMFONT(16);
        [buyBtn setTitleColor:kGetColor(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        buyBtn.backgroundColor = [UIColor greenColor];
        [buyBtn addTarget:self action:@selector(buyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (void)chatBtnClicked:(id)sender
{
    [self.delegate chat_action];
}

- (void)callBtnClicked:(id)sender
{
    [self.delegate call_action];
}

- (void)carBtnClicked:(id)sender
{
    [self.delegate cart_action];
}

- (void)addBtnClicked:(id)sender
{
    [self.delegate addToCart_action];
}

- (void)buyBtnClicked:(id)sender
{
    [self.delegate buy_action];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
