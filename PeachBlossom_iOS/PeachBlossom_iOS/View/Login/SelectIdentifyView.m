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
@property (nonatomic, strong) NSString    *selectedString;

@property (nonatomic, strong) UIButton    *tempBtn; //用来记录点击的UIbutton

@end


@implementation SelectIdentifyView
@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame identifyArr:(NSArray *)iArr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.selectedString = @"";
        
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
        self.nameFiled.layer.cornerRadius = 20;
        self.nameFiled.layer.masksToBounds = YES;
        self.nameFiled.textAlignment = NSTextAlignmentCenter;
        self.nameFiled.backgroundColor = kGetColor(0xf5, 0xf5, 0xf5);
        self.nameFiled.placeholder = @"最多输入10个字";
        
        UILabel *msglab = [[UILabel alloc] init];
        [self addSubview:msglab];
        [msglab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameFiled.mas_bottom).offset(20);
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(16);
        }];
        NSString *aStr = @"请从下方选择身份 (只能选择一个)";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,8)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(8,str.length-8)];
        [str addAttribute:NSForegroundColorAttributeName value:kGetColor(0x22, 0x22, 0x22) range:NSMakeRange(0,str.length)];
        [msglab setAttributedText:str];
        msglab.textAlignment = NSTextAlignmentCenter;
        
        UIScrollView *sview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 136+10, self.frame.size.width, self.frame.size.height-(136+16+5)-60)];
        [self addSubview:sview];
        sview.backgroundColor = [UIColor whiteColor];
        
                
        int x = 0;
        int y = 10;
        int w = 80;
        int h = 28;
        int x_gap = (self.frame.size.width-w*3)/4;
        int y_gap = 12;
        
        
        int row = (int)iArr.count % 3 == 0 ? (int)iArr.count/3 : (int)iArr.count/3+1;
        sview.contentSize = CGSizeMake(self.frame.size.width, y+(y_gap+h)*row);
        
        for(int i=0;i<iArr.count;i++)
        {
            int r = (int)i % 3; //0 1 2
            int c = (int)i / 3;
            
            int _x = x+x_gap*(r+1) + w*r;
            int _y = y+y_gap*c + h*c;
            
            UIButton *tagbtn = [[UIButton alloc] initWithFrame:CGRectMake(_x, _y, w, h)];
            [tagbtn setTitle:iArr[i] forState:UIControlStateNormal];
            tagbtn.titleLabel.font = CUSTOMFONT(12);
            tagbtn.tag = i;
            tagbtn.layer.cornerRadius = 12;
            tagbtn.layer.masksToBounds = YES;
            [tagbtn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
            [tagbtn setBackgroundColor:kGetColor(0xf5, 0xf5, 0xf5)];
            tagbtn.layer.borderColor = kGetColor(0xf5, 0xf5, 0xf5).CGColor;
            tagbtn.layer.borderWidth = 1.;
            [tagbtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [sview addSubview:tagbtn];
        }
                        
        
        UIButton *okBtn = [[UIButton alloc] init];
        [self addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(54);
            make.right.equalTo(self.mas_right).offset(-54);
            make.height.mas_equalTo(40);
        }];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        okBtn.titleLabel.font = CUSTOMFONT(16);
        okBtn.layer.cornerRadius = 20;
        okBtn.layer.masksToBounds = YES;
        [okBtn setTitleColor:kGetColor(0xff, 0xff, 0xff) forState:UIControlStateNormal];
        [okBtn setBackgroundColor:kGetColor(0x46, 0xc6, 0x7b)];
        [okBtn addTarget:self action:@selector(okBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


- (void)closeBtnClicked:(id)sender
{
    [self.delegate disMissIdentifyView];
}

- (void)okBtnClicked:(id)sender
{
    [self.delegate confirmInfoIdentifyName:self.nameFiled.text
                                  identify:self.selectedString];
}

- (void)tagBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.selectedString = btn.titleLabel.text;
    
    if(self.tempBtn)
    {
        [self.tempBtn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
        [self.tempBtn setBackgroundColor:kGetColor(0xf5, 0xf5, 0xf5)];
        self.tempBtn.layer.borderColor = kGetColor(0xf5, 0xf5, 0xf5).CGColor;
    }
    
    [btn setTitleColor:kGetColor(0x46, 0xc6, 0x7b) forState:UIControlStateNormal];
    [btn setBackgroundColor:kGetColor(0xff, 0xff, 0xff)];
    btn.layer.borderColor = kGetColor(0x46, 0xc6, 0x7b).CGColor;
    
    
    self.tempBtn = btn;
}



@end
