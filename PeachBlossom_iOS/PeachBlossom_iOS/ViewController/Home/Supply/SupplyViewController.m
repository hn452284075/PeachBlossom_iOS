//
//  SupplyViewController.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SupplyViewController.h"
#import "ProjectStandardUIDefineConst.h"
#import "Masonry.h"

@interface SupplyViewController ()

@end

@implementation SupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //顶部背景图片
    UIImageView *topImg = [[UIImageView alloc] init];
    [self.view addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(198.5);
    }];
    topImg.image = IMAGE(@"topImage");
    
    //标题
    UILabel *titleLab = [[UILabel alloc] init];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(37.5);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(15.5);
    }];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"供应大厅";
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = kGetColor(255, 255, 255);
    
    //返回箭头
    UIButton *backBtn = [[UIButton alloc] init];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(12);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    [backBtn setBackgroundImage:IMAGE(@"supply_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backFrontController:) forControlEvents:UIControlEventTouchUpInside];
        
    //搜索框
    UIView *seachView = [[UIView alloc] init];
    [self.view addSubview:seachView];
    [seachView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(11.5);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.height.mas_equalTo(30);
    }];
    seachView.backgroundColor = [UIColor whiteColor];
    seachView.layer.cornerRadius=15;
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setImage:IMAGE(@"home-seacher") forState:UIControlStateNormal];
    [seachBtn setTitle:@"请输入商品" forState:UIControlStateNormal];
    [seachBtn setTitleColor:KTextColor forState:UIControlStateNormal];
    [seachBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
    seachBtn.titleLabel.font= CUSTOMFONT(12);
    [seachView addSubview:seachBtn];
    [seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(seachView.mas_centerX);
        make.centerY.equalTo(seachView.mas_centerY);
    }];
    [seachBtn addTarget:self action:@selector(seachBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索框下方广告图
    UIButton *adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:adBtn];
    [adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(57);
        make.left.equalTo(self.view.mas_left).offset(14);
        make.right.equalTo(self.view.mas_right).offset(-14);
        make.height.mas_equalTo(120);
    }];
    [adBtn setBackgroundImage:IMAGE(@"supply_banner") forState:UIControlStateNormal];
    
    //中间部分 产品种类view
    
}

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------ 返回上级页面
- (void)backFrontController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------ 顶部搜索按钮点击事件
- (void)seachBtnClicked:(id)sender
{
    
}


#pragma mark ------------------------Init---------------------------------
 
#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

@end
