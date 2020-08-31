//
//  SelectIdentifyView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SelectIdentifyView.h"

@interface SelectIdentifyView()

@property (nonatomic, strong) UITextField *nameFiled;

@end


@implementation SelectIdentifyView


- (instancetype)initWithFrame:(CGRect)frame identifyArr:(NSArray *)iArr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *closeBtn = [[UIButton alloc] init];
        [self addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(14);
            make.right.equalTo(self.mas_right).offset(-14);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
        }];
        [closeBtn setBackgroundImage:IMAGE(@"supply_close") forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *namelab = [[UILabel alloc] init];
        [self addSubview:namelab];
        [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(30);
            make.left.equalTo(self.mas_left).offset(14);
            make.right.equalTo(self.mas_right).offset(-14);
            make.height.mas_equalTo(16);
        }];
        namelab.text = @"姓名";
        namelab.textColor = kGetColor(0x22, 0x22, 0x22);
        namelab.textAlignment = NSTextAlignmentCenter;
        namelab.font = CUSTOMFONT(16);
        
        self.nameFiled = [[UITextField alloc] init];
        [self addSubview:self.nameFiled];
        [self.nameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(namelab.mas_bottom).offset(13);
            make.left.equalTo(self.mas_left).offset(54);
            make.right.equalTo(self.mas_right).offset(-54);
            make.height.mas_equalTo(40);
        }];
        self.nameFiled.layer.cornerRadius = 15;
        self.nameFiled.layer.masksToBounds = YES;
        self.nameFiled.textAlignment = NSTextAlignmentCenter;
        self.nameFiled.backgroundColor = kGetColor(0xf5, 0xf5, 0xf5);
        self.nameFiled.placeholder = @"最多输入10个字";
    }
    return self;
}


- (void)closeBtnClicked:(id)sender
{
    [self removeFromSuperview];
}


@end
