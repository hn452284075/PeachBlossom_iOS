//
//  StoreViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@property (nonatomic, strong) UIButton  *orderBtn;  //订单管理
@property (nonatomic, strong) UIButton  *storeBtn;  //店铺管理
@property (nonatomic, strong) UIButton  *smartBtn;  //马商通

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
    
    //中间白色发布商品view
    UIButton *pulishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pulishBtn setImage:IMAGE(@"home-seacher") forState:UIControlStateNormal];
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
    
//    self.orderBtn = [self factoryButton:self.orderBtn img:<#(NSString *)#> tag:<#(int)#>]
    
    
}

#pragma mark ------------------------Init---------------------------------
- (UIButton *)factoryButton:(UIButton *)btn img:(NSString *)imgname tag:(int)tag
{
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn setImage:IMAGE(imgname) forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self
            action:@selector(btnClciked:)
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


 
#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
- (void)btnClciked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
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
