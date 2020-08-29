//
//  LoginViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "LoginViewController.h"
#import "Util.h"
@interface LoginViewController ()

@property (nonatomic, strong) UITextField *phoneFiled;
@property (nonatomic, strong) UITextField *codeFiled;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *clearBtn;

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
      
    int iphonex_height = 0;
    if(iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)
        iphonex_height = 25;
  
    //返回按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(17+iphonex_height);
        make.left.equalTo(self.view.mas_left).offset(17);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    [closeBtn setBackgroundImage:IMAGE(@"login_close") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(backFrontController:) forControlEvents:UIControlEventTouchUpInside];
    
    //中间logo
    UIImageView *logoImg = [[UIImageView alloc] init];
    [self.view addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(69+iphonex_height);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(93);
        make.height.mas_equalTo(93);
    }];
    logoImg.image = IMAGE(@"login_logo");
    
    //输入手机号
    UIView *phonebackview = [[UIView alloc] init];
    [self.view addSubview:phonebackview];
    [phonebackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImg.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(45);
    }];
    phonebackview.backgroundColor = [UIColor whiteColor];
    phonebackview.layer.borderColor = kGetColor(0xeb, 0xeb, 0xeb).CGColor;
    phonebackview.layer.borderWidth = 1.;
    phonebackview.layer.cornerRadius = 22.;
    
    //---手机小图标
    UIImageView *phoneiconImg = [[UIImageView alloc] init];
    [self.view addSubview:phoneiconImg];
    [phoneiconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phonebackview.mas_left).offset(12);
        make.centerY.equalTo(phonebackview.mas_centerY).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    phoneiconImg.image = IMAGE(@"login_phoneicon");
    
    //---清除手机号码按钮，默认隐藏，有文字输入后显示
    self.clearBtn = [[UIButton alloc] init];
    [self.view addSubview:self.clearBtn];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(phonebackview.mas_right).offset(-12);
        make.centerY.equalTo(phonebackview.mas_centerY).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    self.clearBtn.hidden = YES;
    [self.clearBtn setBackgroundImage:IMAGE(@"close-lv") forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(clearPhoneFiled:) forControlEvents:UIControlEventTouchUpInside];
    
    //---手机输入框
    self.phoneFiled = [[UITextField alloc] init];
    [self.view addSubview:self.phoneFiled];
    [self.phoneFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneiconImg.mas_right).offset(14);
        make.centerY.equalTo(phonebackview.mas_centerY).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(35);
    }];
    self.phoneFiled.textColor = kGetColor(0x9a, 0x9a, 0x9a);
    self.phoneFiled.font = CUSTOMFONT(14);
    self.phoneFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneFiled.placeholder = @"请输入手机号";
    [self.phoneFiled addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];

    
    
    //输入验证码
    UIView *codebackview = [[UIView alloc] init];
    [self.view addSubview:codebackview];
    [codebackview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phonebackview.mas_bottom).offset(25);
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(45);
    }];
    codebackview.backgroundColor = [UIColor whiteColor];
    codebackview.layer.borderColor = kGetColor(0xeb, 0xeb, 0xeb).CGColor;
    codebackview.layer.borderWidth = 1.;
    codebackview.layer.cornerRadius = 22.;
    
    //---验证码小图标
    UIImageView *codeiconImg = [[UIImageView alloc] init];
    [self.view addSubview:codeiconImg];
    [codeiconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codebackview.mas_left).offset(12);
        make.centerY.equalTo(codebackview.mas_centerY).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    codeiconImg.image = IMAGE(@"login_codeicon");
    
    //---验证码输入框
    self.codeFiled = [[UITextField alloc] init];
    [self.view addSubview:self.codeFiled];
    [self.codeFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeiconImg.mas_right).offset(14);
        make.centerY.equalTo(codebackview.mas_centerY).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(35);
    }];
    self.codeFiled.textColor = kGetColor(0x9a, 0x9a, 0x9a);
    self.codeFiled.font = CUSTOMFONT(14);
    self.codeFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.codeFiled.placeholder = @"请输入验证码";
    [self.codeFiled addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
    //-------获取验证码按钮
    UIButton *getCodeBtn = [[UIButton alloc] init];
    [self.view addSubview:getCodeBtn];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codebackview.mas_right).offset(-14);
        make.centerY.equalTo(codebackview.mas_centerY).offset(0);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(26);
    }];
    [self factory_btn:getCodeBtn
            backColor:[UIColor whiteColor]
            textColor:kGetColor(0x46, 0xc6, 0x7c)
          borderColor:kGetColor(0x46, 0xc6, 0x7c)
                title:@"获取验证码"
             fontsize:14
               corner:13
                  tag:1];
    
    
    //登录按钮
    self.loginBtn = [[UIButton alloc] init];
    self.loginBtn.alpha = 0.5;
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codebackview.mas_bottom).offset(35);
        make.left.equalTo(self.view.mas_left).offset(35);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(45);
    }];
    [self factory_btn:self.loginBtn
           backColor:kGetColor(0x46, 0xc6, 0x7c)
           textColor:[UIColor whiteColor]
         borderColor:kGetColor(0x46, 0xc6, 0x7c)
               title:@"登录"
            fontsize:18
              corner:22
                 tag:2];
    
    //其它方式登录
    UILabel *lab = [[UILabel alloc] init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(115);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.height.mas_equalTo(15);
    }];
    lab.textColor = kGetColor(0xbb, 0xbb, 0xbb);
    lab.font = CUSTOMFONT(12);
    lab.text = @"———— 其它方式登录 ————";
    
    //微信图标
    UIButton *wechatlogoBtn = [[UIButton alloc] init];
    [self.view addSubview:wechatlogoBtn];
    [wechatlogoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    [wechatlogoBtn setBackgroundImage:IMAGE(@"login_wechatlogo") forState:UIControlStateNormal];
    [wechatlogoBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    wechatlogoBtn.tag = 10;
    
    //隐私协议
    UIButton *privateBtn = [[UIButton alloc] init];
    [self.view addSubview:privateBtn];
    [privateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wechatlogoBtn.mas_bottom).offset(15);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(300);
    }];
    
    NSString * aStr = @"登录即代表您已同意《用户协议/隐私政策》";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",aStr]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,aStr.length)];
    [str addAttribute:NSForegroundColorAttributeName value:kGetColor(0x9a, 0x9a, 0x9a) range:NSMakeRange(0,9)];
    [str addAttribute:NSForegroundColorAttributeName value:kGetColor(0x46, 0xc6, 0x7c) range:NSMakeRange(9,aStr.length-9)];
    [privateBtn setAttributedTitle:str forState:UIControlStateNormal];
    [privateBtn addTarget:self action:@selector(privateBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //联系客服
    UIButton *connectBtn = [[UIButton alloc] init];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(privateBtn.mas_bottom).offset(9);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(150);
    }];
    
    NSString * connectStr = @"如有问题点击联系客户";
    NSMutableAttributedString *tempstr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",connectStr]];
    [tempstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,connectStr.length)];
    [tempstr addAttribute:NSForegroundColorAttributeName value:kGetColor(0x9a, 0x9a, 0x9a) range:NSMakeRange(0,6)];
    [tempstr addAttribute:NSForegroundColorAttributeName value:kGetColor(0x46, 0xc6, 0x7c) range:NSMakeRange(6,connectStr.length-6)];
    [connectBtn setAttributedTitle:tempstr forState:UIControlStateNormal];
    [connectBtn addTarget:self action:@selector(connectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark ------------------------Private------------------------------
- (void)factory_btn:(UIButton *)btn backColor:(UIColor *)bcolor textColor:(UIColor *)tcolor borderColor:(UIColor *)dcolor title:(NSString *)title fontsize:(int)fsize corner:(float)csize
                tag:(int)tag;
{
    btn.backgroundColor = bcolor;
    btn.layer.borderColor = dcolor.CGColor;
    [btn setTitleColor:tcolor forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.;
    btn.layer.cornerRadius = csize;
    btn.titleLabel.font = CUSTOMFONT(fsize);
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
}


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------ 返回上级页面
- (void)backFrontController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------ 隐私协议点击
- (void)privateBtnClicked:(id)sender
{
    
}

#pragma mark ------------------------ 联系客服
- (void)connectBtnClicked:(id)sender
{
    
}

- (void)clearPhoneFiled:(id)sender
{
    self.phoneFiled.text = @"";
    self.loginBtn.alpha = 0.5;
}


#pragma mark ------------------------ 获取手机验证码
- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            NSLog(@"获取验证码");
        }
            break;
        case 2:
        {
            NSLog(@"登录");
            if(self.phoneFiled.text.length > 0 && self.codeFiled.text.length > 0)
            {
                
            }
        }
            break;
        case 10:
        {
            NSLog(@"微信登录");
        }
            break;
        default:
            break;
    }
}

- (void)changedTextField:(UITextField *)sender
{
    if(self.phoneFiled.text.length > 0)
        self.clearBtn.hidden = NO;
    else
        self.clearBtn.hidden = YES;
    
    if(self.phoneFiled.text.length > 0 && self.codeFiled.text.length > 0)
        self.loginBtn.alpha = 1.;
    else
        self.loginBtn.alpha = 0.5;
}


#pragma mark ------------------------Delegate-----------------------------

 
@end
