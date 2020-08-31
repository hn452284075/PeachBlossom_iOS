//
//  StoreTopView.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "StoreTopView.h"

@implementation StoreTopView


- (instancetype)initWithFrame:(CGRect)frame name:(NSString *)name grade:(NSString *)grade upNumber:(int)uvalue downNumber:(int)dvalue
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *namelab = [[UILabel alloc] init];
        [self addSubview:namelab];
        [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(15);
        }];
        namelab.text = name;
        namelab.textAlignment = NSTextAlignmentCenter;
        namelab.font = CUSTOMFONT(16);
        namelab.textColor = [UIColor whiteColor];
        
        
        UILabel *gradelab = [[UILabel alloc] init];
        [self addSubview:gradelab];
        [gradelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(namelab.mas_bottom).offset(15);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right).offset(-kScreenWidth/2);
            make.height.mas_equalTo(15);
        }];
        gradelab.text = grade;
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
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
