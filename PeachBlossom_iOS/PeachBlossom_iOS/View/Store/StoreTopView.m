//
//  StoreTopView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "StoreTopView.h"

@implementation StoreTopView
@synthesize delegate;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *namelab = [[UILabel alloc] init];
        namelab.tag = 1;
        [self addSubview:namelab];
        [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(15);
        }];
        namelab.textAlignment = NSTextAlignmentCenter;
        namelab.font = CUSTOMFONT(16);
        namelab.textColor = [UIColor whiteColor];
        
        
        UILabel *gradelab = [[UILabel alloc] init];
        gradelab.tag = 2;
        [self addSubview:gradelab];
        [gradelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(namelab.mas_bottom).offset(15);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right).offset(-kScreenWidth/2);
            make.height.mas_equalTo(15);
        }];
        gradelab.textAlignment = NSTextAlignmentRight;
        gradelab.font = CUSTOMFONT(12);
        gradelab.textColor = [UIColor whiteColor];
        
        
        UIButton *gradebtn = [[UIButton alloc] init];
        [self addSubview:gradebtn];
        [gradebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(gradelab.mas_centerY);
            make.left.equalTo(self.mas_left).offset(kScreenWidth/2+5);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(77);
        }];
        [gradebtn setTitle:@"等级规则 >" forState:UIControlStateNormal];
        gradebtn.layer.cornerRadius = 10;
        gradebtn.backgroundColor = kGetColor(92, 202, 103);
        gradebtn.titleLabel.font = CUSTOMFONT(12);
        [gradebtn addTarget:self action:@selector(gradeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *upBtn = [[UIButton alloc] init];
        upBtn.tag = 3;
        [self addSubview:upBtn];
        [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(gradebtn.mas_bottom).offset(30);
            make.centerX.equalTo(self.mas_centerX).offset(-(kScreenWidth/4));
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(100);
        }];
        upBtn.titleLabel.font = CUSTOMFONT(18);
        [upBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [gradebtn addTarget:self action:@selector(upBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *upBtn_1 = [[UIButton alloc] init];
        [self addSubview:upBtn_1];
        [upBtn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upBtn.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX).offset(-(kScreenWidth/4));
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(100);
        }];
        [upBtn_1 setTitle:@"已上架" forState:UIControlStateNormal];
        upBtn_1.titleLabel.font = CUSTOMFONT(12);
        [upBtn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [upBtn_1 addTarget:self action:@selector(upBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *downBtn = [[UIButton alloc] init];
        downBtn.tag = 4;
        [self addSubview:downBtn];
        [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(gradebtn.mas_bottom).offset(30);
            make.centerX.equalTo(self.mas_centerX).offset((kScreenWidth/4));
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(100);
        }];
        downBtn.titleLabel.font = CUSTOMFONT(18);
        [downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [downBtn addTarget:self action:@selector(downBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *downBtn_1 = [[UIButton alloc] init];
        [self addSubview:downBtn_1];
        [downBtn_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(downBtn.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX).offset((kScreenWidth/4));
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(100);
        }];
        [downBtn_1 setTitle:@"已下架" forState:UIControlStateNormal];
        downBtn_1.titleLabel.font = CUSTOMFONT(12);
        [downBtn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [downBtn_1 addTarget:self action:@selector(downBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)configTopViewName:(NSString *)name grade:(NSString *)grade upNumber:(int)uvalue downNumber:(int)dvalue
{
    UILabel *namelab = [self viewWithTag:1];
    namelab.text = name;
    
    UILabel *gradelab = [self viewWithTag:2];
    gradelab.text = grade;
    
    UIButton *upbtn = [self viewWithTag:3];
    [upbtn setTitle:[NSString stringWithFormat:@"%d",uvalue] forState:UIControlStateNormal];
    
    UIButton *downbtn = [self viewWithTag:4];
    [downbtn setTitle:[NSString stringWithFormat:@"%d",dvalue] forState:UIControlStateNormal];
}



- (void)gradeBtnClicked:(id)sender
{
    [self gradeRuleFunction];
}


- (void)upBtnClicked:(id)sender
{
    [self upGoodsFunction];
}


- (void)downBtnClicked:(id)sender
{
    [self downGoodsFunction];
}



@end
