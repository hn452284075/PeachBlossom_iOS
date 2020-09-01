//
//  SetPriceTableViewCell.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/9/1.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SetPriceTableViewCell.h"

@implementation SetPriceTableViewCell
@synthesize delegate;

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self)
//    {
//        [self setUI];
//    }
//
//    return self;
//}

- (void)setUI
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kScreenWidth);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *namelab = [[UILabel alloc] init];
    namelab.tag = 1;
    [self addSubview:namelab];
    [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_offset(60);
        make.height.mas_equalTo(15);
    }];
    namelab.textAlignment = NSTextAlignmentLeft;
    namelab.font = CUSTOMFONT(14);
    namelab.textColor = kGetColor(0x22, 0x22, 0x22);
    
    UIImageView *iconimg = [[UIImageView alloc] init];
    iconimg.tag = 2;
    [self addSubview:iconimg];
    [iconimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_offset(22);
        make.height.mas_equalTo(22);
    }];
    
    
    UITextField *filed1 = [[UITextField alloc] init];
    filed1.tag = 3;
    [self addSubview:filed1];
    [filed1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(self.mas_left).offset(93);
        make.width.mas_offset(130);
        make.height.mas_equalTo(30);
    }];
    
    UITextField *filed2 = [[UITextField alloc] init];
    filed2.tag = 4;
    [self addSubview:filed2];
    [filed2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(filed1.mas_right).offset(15);
        make.width.mas_offset(130);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *msglab = [[UILabel alloc] init];
    msglab.tag = 5;
    [self addSubview:msglab];
    [msglab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(filed2.mas_right).offset(15);
        make.width.mas_offset(60);
        make.height.mas_equalTo(15);
    }];
    msglab.textAlignment = NSTextAlignmentLeft;
    msglab.font = CUSTOMFONT(14);
    msglab.textColor = kGetColor(0x22, 0x22, 0x22);
    
    
    UIImageView *arrowimg = [[UIImageView alloc] init];
    arrowimg.tag = 6;
    [self addSubview:arrowimg];
    [arrowimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.mas_offset(14);
        make.height.mas_equalTo(19);
    }];
    arrowimg.image = IMAGE(@"rightArrow");
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UILabel *namelab = [[UILabel alloc] init];
        namelab.tag = 1;
        [self addSubview:namelab];
        [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.mas_offset(70);
            make.height.mas_equalTo(15);
        }];
        namelab.textAlignment = NSTextAlignmentLeft;
        namelab.font = CUSTOMFONT(14);
        namelab.textColor = kGetColor(0x22, 0x22, 0x22);

        UIButton *iconimg = [[UIButton alloc] init];
        iconimg.tag = 2;
        [self addSubview:iconimg];
        [iconimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.mas_offset(22);
            make.height.mas_equalTo(22);
        }];
        [iconimg addTarget:self
                    action:@selector(iconBtnClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        

        UITextField *filed1 = [[UITextField alloc] init];
        filed1.tag = 3;
        [self addSubview:filed1];
        [filed1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(self.mas_left).offset(93);
            make.width.mas_offset(130);
            make.height.mas_equalTo(30);
        }];
        filed1.font = CUSTOMFONT(14);

        UITextField *filed2 = [[UITextField alloc] init];
        filed2.tag = 4;
        [self addSubview:filed2];
        [filed2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(filed1.mas_right).offset(15);
            make.width.mas_offset(130);
            make.height.mas_equalTo(30);
        }];
        filed2.font = CUSTOMFONT(14);

        UILabel *msglab = [[UILabel alloc] init];
        msglab.tag = 5;
        [self addSubview:msglab];
        [msglab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.left.equalTo(filed2.mas_right).offset(15);
            make.width.mas_offset(60);
            make.height.mas_equalTo(15);
        }];
        msglab.textAlignment = NSTextAlignmentLeft;
        msglab.font = CUSTOMFONT(14);
        msglab.textColor = kGetColor(0x22, 0x22, 0x22);


        UIImageView *arrowimg = [[UIImageView alloc] init];
        arrowimg.tag = 6;
        [self addSubview:arrowimg];
        [arrowimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.right.equalTo(self.mas_right).offset(-15);
            make.width.mas_offset(14);
            make.height.mas_equalTo(19);
        }];
        arrowimg.image = IMAGE(@"rightArrow");
    }
    return self;
}

- (void)configCellTitle:(NSString *)title actionImg:(NSString *)image f1String:(NSString *)f1string f1DefaultString:(NSString *)fd1string f2String:(NSString *)f2string f2DefaultString:(NSString *)fd2string msgString:(NSString *)string{
    
    UILabel *lab1 = [self viewWithTag:1];
    lab1.text = title;
    
    UIButton *addimg = [self viewWithTag:2];
    [addimg setImage:IMAGE(image) forState:UIControlStateNormal];
    
    UITextField *filed1 = [self viewWithTag:3];
    if(f1string.length == 0)
        filed1.placeholder = fd1string;
    else
        filed1.text = f1string;
    
    UITextField *filed2 = [self viewWithTag:4];
    if(f2string.length == 0)
        filed2.placeholder = fd2string;
    else
        filed2.text = f2string;
    
    UILabel *lab5 = [self viewWithTag:5];
    lab5.text = string;
}

- (void)configCellTitleShow:(BOOL)flag1 filed1:(BOOL)flag2 filed2:(BOOL)flag3 msglab:(BOOL)flag4 arrowImg:(BOOL)flag5
{
    UILabel *lab1 = [self viewWithTag:1];
    lab1.hidden = !flag1;
    
    UIButton *addimg = [self viewWithTag:2];
    if(!flag1)
        addimg.hidden = NO;
    else
        addimg.hidden = YES;
    
    UITextField *filed1 = [self viewWithTag:3];
    filed1.hidden = !flag2;
    
    UITextField *filed2 = [self viewWithTag:4];
    filed2.hidden = !flag3;
    
    UILabel *lab5 = [self viewWithTag:5];
    lab5.hidden = !flag4;
    
    UIImageView *arrowimg = [self viewWithTag:6];
    arrowimg.hidden = !flag5;
}


- (void)iconBtnClicked:(id)sender
{
    UIImageView *arrowimg = [self viewWithTag:6];
    if(arrowimg.hidden)
        [self.delegate addOrSubFunction:0];
    else
        [self.delegate addOrSubFunction:1];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
