//
//  StoreViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreTopView.h"

@interface StoreViewController ()

@property (nonatomic, strong) StoreTopView  *topView;

@property (nonatomic, strong) UIButton  *orderBtn;  //订单管理
@property (nonatomic, strong) UILabel   *orderLabel;
@property (nonatomic, strong) UIButton  *storeBtn;  //店铺管理
@property (nonatomic, strong) UILabel   *storeLabel;
@property (nonatomic, strong) UIButton  *smartBtn;  //马商通
@property (nonatomic, strong) UILabel   *smartLabel;

@property (nonatomic, strong) UIButton  *bannerBtn;  //banner

@end

@implementation StoreViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int iphonex_height = 0;
    if(iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)
        iphonex_height = 20;
    
    //绿色背景view
    UIImageView *bgview = [[UIImageView alloc] init];
    [self.view addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(260+iphonex_height);
    }];
    bgview.image = IMAGE(@"storebackgroundimg");
    
    //顶部相关信息显示view
    [self _initTopViewWithLogin];
    
    
    //中间白色发布商品view
    UIButton *pulishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pulishBtn setImage:IMAGE(@"storepuplishicon") forState:UIControlStateNormal];
    [pulishBtn setTitle:@"发布商品" forState:UIControlStateNormal];
    [pulishBtn setTitleColor:KTextColor forState:UIControlStateNormal];
    [pulishBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
    pulishBtn.titleLabel.font= CUSTOMFONT(16);
    [self.view addSubview:pulishBtn];
    [pulishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(170+iphonex_height);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.height.mas_equalTo(90);
    }];
    [pulishBtn setBackgroundColor:[UIColor whiteColor]];
    pulishBtn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    pulishBtn.layer.cornerRadius = 5.;
    pulishBtn.layer.masksToBounds = NO;
    pulishBtn.layer.shadowRadius = 13;
    pulishBtn.layer.shadowOffset = CGSizeMake(0.0f,0.0f);
    pulishBtn.layer.shadowOpacity = 0.5f;
    
    //中间部分三个按钮和标签
    self.orderBtn = [self factoryButton:self.orderBtn img:@"storeicon_1" tag:1];
    self.storeBtn = [self factoryButton:self.storeBtn img:@"storeicon_2" tag:2];
    self.smartBtn = [self factoryButton:self.smartBtn img:@"storeicon_3" tag:3];
    NSArray *btnArray = [[NSArray alloc] initWithObjects:self.orderBtn,self.storeBtn,self.smartBtn, nil];
    
    int gap = (kScreenWidth-50*3-40*2)/2;
    [btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:gap leadSpacing:40 tailSpacing:40];
    [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(295+iphonex_height);
    }];
    
    self.orderLabel = [self factoryLabel:self.orderLabel string:@"订单管理"];
    self.storeLabel = [self factoryLabel:self.storeLabel string:@"店铺管理"];
    self.smartLabel = [self factoryLabel:self.smartLabel string:@"马商通"];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.orderBtn.mas_centerX);
        make.top.equalTo(self.orderBtn.mas_bottom).offset(15);
    }];
    [self.storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.storeBtn.mas_centerX);
        make.top.equalTo(self.orderBtn.mas_bottom).offset(15);
    }];
    [self.smartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.smartBtn.mas_centerX);
        make.top.equalTo(self.orderBtn.mas_bottom).offset(15);
    }];
    
    //banner图
    self.bannerBtn = [self factoryButton:self.bannerBtn img:@"storebanner" tag:4];
    [self.bannerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderLabel.mas_bottom).offset(25);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.height.mas_equalTo(105);
    }];
    
    
}

#pragma mark ------------------------Init---------------------------------
- (UIButton *)factoryButton:(UIButton *)btn img:(NSString *)imgname tag:(int)tag
{
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:btn];
    [btn setImage:IMAGE(imgname) forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self
            action:@selector(btnClciked:)
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UILabel *)factoryLabel:(UILabel *)lab string:(NSString *)str
{
    lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 14)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = str;
    lab.font = CUSTOMFONT(14);
    lab.textColor = kGetColor(0x34, 0x34, 0x34);
    [self.view addSubview:lab];
    return lab;
}

#pragma mark ------------------ 已登录情况的view
- (void)_initTopViewWithLogin
{
    int iphonex_height = 0;
    if(iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)
        iphonex_height = 20;
    self.topView = [[StoreTopView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) name:@"澳大利亚" grade:@"个人等级:88" upNumber:100 downNumber:100];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40+iphonex_height);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(130);
    }];
    self.topView.backgroundColor = [UIColor clearColor];
}

#pragma mark ------------------ 没有登录的view
//- (UIView *)_initTopViewWithoutLogin
//{
//    return nil;
//}


 
#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
- (void)btnClciked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1: //订单管理
        {
            
        }
            break;
        case 2: //店铺管理
        {
            
        }
            break;
        case 3: //马商通
        {
            
        }
            break;
        case 4: //banner点击事件
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark ------------------------Delegate-----------------------------


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

 

@end
