//
//  GoodsInfoViewController.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "Masonry.h"
#import "SDCycleScrollView.h"
#import "SupplyGoodsInfoView.h"

@interface GoodsInfoViewController ()<SupplyGoodsInfoDelegate>

//返回按钮
@property (nonatomic, strong) UIButton *backBtn;

//底部scrollview
@property (nonatomic, strong) UIScrollView  *mainScrollerView;

//顶部左右滑动大图
@property (nonatomic, strong) SDCycleScrollView *infoImgScrollView;

//商品基本信息view
@property (nonatomic, strong) SupplyGoodsInfoView *goodsInfoView;

//商品规格view
@property (nonatomic, strong) UIView *specView;


@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mainScrollerView = [[UIScrollView alloc] init];
    [self.view addSubview:self.mainScrollerView];
    [self.mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight);
    }];
    self.mainScrollerView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*3);
    self.mainScrollerView.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
    self.backBtn = [[UIButton alloc] init];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(31);
        make.left.equalTo(self.view.mas_left).offset(11);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    [self.backBtn setImage:IMAGE(@"supply_back") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.infoImgScrollView = [[SDCycleScrollView alloc] init];
    [self.mainScrollerView addSubview:self.infoImgScrollView];
    [self.infoImgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainScrollerView.mas_top).offset(-44);
        make.left.equalTo(self.mainScrollerView.mas_left).offset(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(375);
    }];
    NSArray *imagesURLStrings = @[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3154735394,3121028424&fm=26&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1346142700,2282998096&fm=26&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597493597049&di=2fb9c91b233399c2e7549c8553f18432&imgtype=0&src=http%3A%2F%2Fimage.tupian114.com%2F20160901%2F1903030731.jpg"
                             ];
    self.infoImgScrollView.imageURLStringsGroup = imagesURLStrings;
    self.infoImgScrollView.autoScroll = NO;
    
    [self initGoodsInfo_TitleView];
    [self initGoodsInfo_SpecView];
}

#pragma mark ------------------------Init---------------------------------
- (void)initGoodsInfo_TitleView
{
    self.goodsInfoView = [[[NSBundle mainBundle] loadNibNamed:@"SupplyGoodsInfoView" owner:self options:nil] lastObject];
    self.goodsInfoView.delegate = self;
    [self.mainScrollerView addSubview:self.goodsInfoView];
    [self.goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoImgScrollView.mas_bottom).offset(15);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(159);
    }];
    [self.goodsInfoView _initGoodsTitleInfo:@"撒可富哈佛哈的发发飞洒发斯蒂芬斯蒂芬士大夫红烧豆腐很看好房SDK"
                      price:@"88888"
                     weight:@"999898斤起"
                   distance:@"距离奥利大力98888公里"
                        see:@"199887人看过"];
}

//根据商品规格展示界面
- (void)initGoodsInfo_SpecView
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"2.9/斤",@"次品",
                               @"2.9/斤",@"好品",
                               @"2.9/斤",@"良品",
                               @"2.9/斤",@"优品",nil];
    NSArray *keyarr = [dic allKeys];
    
    self.specView = [[UIView alloc] init];
    [self.mainScrollerView addSubview:self.specView];
    [self.specView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsInfoView.mas_bottom).offset(16);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(30+30*keyarr.count);
    }];
    self.specView.backgroundColor = [UIColor whiteColor];
    
    UILabel *specLab = [[UILabel alloc] init];
    [self.specView addSubview:specLab];
    [specLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specView.mas_top).offset(17);
        make.left.equalTo(self.specView.mas_left).offset(14);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    specLab.textAlignment = NSTextAlignmentCenter;
    specLab.text = @"规格";
    specLab.font = [UIFont systemFontOfSize:14];
    specLab.textColor = kGetColor(0x99, 0x99, 0x99);
    
    for(int i=0;i<keyarr.count;i++)
    {
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(84, 17+33*i, (kScreenWidth-84)/2, 15)];
        
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab1.frame.origin.x+lab1.frame.size.width, 17+33*i, (kScreenWidth-120)/2, 15)];
        
        lab1.textAlignment = NSTextAlignmentLeft;
        lab2.textAlignment = NSTextAlignmentRight;
        
        lab1.font = [UIFont systemFontOfSize:14];
        lab2.font = [UIFont systemFontOfSize:14];
        
        lab1.textColor = kGetColor(0x11, 0x11, 0x11);
        lab2.textColor = kGetColor(0x11, 0x11, 0x11);
        
        lab1.text = keyarr[i];
        lab2.text = [dic objectForKey:keyarr[i]];
        
        [self.specView addSubview:lab1];
        [self.specView addSubview:lab2];
    }
}


#pragma mark ------------------------View Event---------------------------
- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------Delegate-----------------------------
- (void)supply_share_Action
{
    NSLog(@"供应大厅--商品分享按钮");
}

- (void)supply_love_Action
{
    NSLog(@"供应大厅--商品收藏按钮");
}

@end
