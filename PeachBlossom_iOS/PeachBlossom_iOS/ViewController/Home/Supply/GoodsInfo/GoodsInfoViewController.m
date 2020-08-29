//
//  GoodsInfoViewController.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "GoodsCommentController.h"
#import "Masonry.h"
#import "SDCycleScrollView.h"
#import "SupplyGoodsInfoView.h"
#import "ExpressInfoView.h"
#import "CommentHeaderView.h"
#import "CommentOneView.h"
#import "ShopInfoView.h"
#import "BottumBuyView.h"
#import "AddToCartView.h"

@interface GoodsInfoViewController ()<SupplyGoodsInfoDelegate,ExpressInfoViewDlegate,ShopInfoViewDelegate,UIWebViewDelegate,BottumBuyViewDelegate,AddToCartDelegate,CommentHeaderViewDelegate>

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

//物流view
@property (nonatomic, strong) UIView *expressView;
//弹出的物流详情view
@property (nonatomic, strong) ExpressInfoView *expressInfoView;

//评论的头部View
@property (nonatomic, strong) CommentHeaderView *commentheaderview;
//具体的评论
@property (nonatomic, strong) CommentOneView *commnetView_1;
@property (nonatomic, strong) CommentOneView *commnetView_2;

//商店信息
@property (nonatomic, strong) ShopInfoView *shopInfoView;

//底部webview
@property (nonatomic, strong) UIWebView *detailInfoWebview;

//最下方的聊一聊 、 加购物车的view
@property (nonatomic, strong) BottumBuyView *buyView;

//加入购物车弹出框
@property (nonatomic, strong) AddToCartView *addCartView;

@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int iphonex_height = 0;
    if(iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)
        iphonex_height = 20;
    self.mainScrollerView = [[UIScrollView alloc] init];
    [self.view addSubview:self.mainScrollerView];
    [self.mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight-57-iphonex_height);
    }];
    self.mainScrollerView.contentSize = CGSizeMake(kScreenWidth, 1339);
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
    [self initGoodsInfo_SpecView];           //规格
    [self initGoodsInfo_expressView];        //物流信息
    [self initGoodsInfo_commentHeaderView];  //评论头部
    [self initGoodsInfo_commentView];        //显示的两条评论
    [self initGoodsInfo_shopInfoView];       //店铺信息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initGoodsInfo_webView];
    });
    [self initGoodsInfo_buyview];
    
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

//物流栏
- (void)initGoodsInfo_expressView
{
    self.expressView = [[UIView alloc] init];
    [self.mainScrollerView addSubview:self.expressView];
    [self.expressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.specView.mas_bottom).offset(15);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(45);
    }];
    self.expressView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] init];
    [self.expressView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(14);
        make.centerY.equalTo(self.expressView.mas_centerY);
    }];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"物流";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = kGetColor(0x99, 0x99, 0x99);
    
    UILabel *infolab = [[UILabel alloc] init];
    [self.expressView addSubview:infolab];
    [infolab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(83);
        make.centerY.equalTo(self.expressView.mas_centerY);
    }];
    infolab.textAlignment = NSTextAlignmentCenter;
    infolab.text = @"整车快递，费用待协商";
    infolab.font = [UIFont systemFontOfSize:14];
    infolab.textColor = kGetColor(0x11, 0x11, 0x11);
    
    UIButton *showinfobtn = [[UIButton alloc] init];
    [self.expressView addSubview:showinfobtn];
    [showinfobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.centerY.equalTo(self.expressView.mas_centerY);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    [showinfobtn setBackgroundImage:IMAGE(@"rightArrow") forState:UIControlStateNormal];
    [showinfobtn addTarget:self action:@selector(showExpressInfoView:) forControlEvents:UIControlEventTouchUpInside];
}

//评论
- (void)initGoodsInfo_commentHeaderView
{
    self.commentheaderview = [[[NSBundle mainBundle] loadNibNamed:@"CommentHeaderView" owner:self options:nil] lastObject];
    self.commentheaderview.delegate = self;
    [self.mainScrollerView addSubview:self.commentheaderview];
    [self.commentheaderview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expressView.mas_bottom).offset(15);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(80);
    }];
}

- (void)initGoodsInfo_commentView
{
    NSString *comment = @"当数据很多列表过，长的时候必行了可以往以下几个方面考虑当，数据很多列表过长的时候优化就势在必行了可以往以下几个方，表过，长的时候必行了可以往以下几个方面考虑当，数据很多列表过长的时候优化就势在必行了可以往以下几个方，表过，长的时候必行了可以往以下几个方面考虑当，数据很多列表过长的时候优化就势在必行了可以往以下几个方面考虑当数据很，多列大暗示法";
    NSArray *imageArr = [[NSArray alloc] initWithObjects:IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"),IMAGE(@"supply_goodsimg"), nil];
        
    
    NSDictionary * dict = @{
        NSFontAttributeName : [UIFont systemFontOfSize:14]
    };
    CGSize size = [comment boundingRectWithSize:CGSizeMake(kScreenWidth-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    int count = (int)imageArr.count%4==0?(int)imageArr.count/4:((int)imageArr.count/4)+1;
    int cvheight = size.height+50+(kScreenWidth-24)/4*count+60;
    
    self.commnetView_1 = [[CommentOneView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) headImage:IMAGE(@"supply_goodsimg") name:@"Rover" comment:comment images:imageArr time:@"2020-08-28" spec:@"特级果" weight:@"100顿" place:@"发往澳大利亚"];
    [self.mainScrollerView addSubview:self.commnetView_1];
    [self.commnetView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentheaderview.mas_bottom).offset(0);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(cvheight);
    }];
    self.commnetView_1.backgroundColor = [UIColor whiteColor];
    
    
    self.commnetView_2 = [[CommentOneView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) headImage:IMAGE(@"supply_goodsimg") name:@"Rover" comment:comment images:imageArr time:@"2020-08-28" spec:@"特级果" weight:@"100顿" place:@"发往澳大利亚"];
    [self.mainScrollerView addSubview:self.commnetView_2];
    [self.commnetView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commnetView_1.mas_bottom).offset(0);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(cvheight);
    }];
    self.commnetView_2.backgroundColor = [UIColor whiteColor];
    
}

- (void)initGoodsInfo_shopInfoView
{
    NSArray *tagarr = [[NSArray alloc] initWithObjects:@"牛牛牛商",@"靠实力",@"企",nil];
    
    self.shopInfoView = [[[NSBundle mainBundle] loadNibNamed:@"ShopInfoView" owner:self options:nil] lastObject];
    self.shopInfoView.delegate = self;
    [self.shopInfoView _initShopInfoWithInfo:IMAGE(@"supply_goodsimg") shopname:@"澳大利亚水果店" shopgrade:@"店铺等级:100" grade_1:@"货品达标:5.0" grade_2:@"卖家服务:2.9" grade_3:@"物流服务:4.8" tagArr:tagarr];
    [self.mainScrollerView addSubview:self.shopInfoView];
    [self.shopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commnetView_2.mas_bottom).offset(15);
        make.right.equalTo(self.infoImgScrollView.mas_right);
        make.left.equalTo(self.infoImgScrollView.mas_left);
        make.height.mas_equalTo(152);
    }];
}

- (void)initGoodsInfo_webView
{
    self.detailInfoWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.shopInfoView.frame.origin.y+self.shopInfoView.frame.size.height+15, kScreenWidth, 300)];
        
    self.detailInfoWebview.userInteractionEnabled = NO;
    self.detailInfoWebview.delegate = self;
    [self.mainScrollerView addSubview:self.detailInfoWebview];
    NSURL *remoteURL = [NSURL URLWithString:@"https://www.jb51.net/article/78989.htm"];
    NSURLRequest *request =[NSURLRequest requestWithURL:remoteURL];
    [self.detailInfoWebview loadRequest:request];
    
    //添加监听
    [self.detailInfoWebview.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"WejinWuLiuViewController"];
}

//监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        float webViewHeight = [self.detailInfoWebview.scrollView contentSize].height;
        CGRect newFrame = self.detailInfoWebview.frame;
        newFrame.size.height = webViewHeight;
       self.detailInfoWebview.frame = newFrame;
        
        self.mainScrollerView.contentSize = CGSizeMake(kScreenWidth, 1339+webViewHeight+660);
    }
}

- (void)initGoodsInfo_buyview
{
    int tempheight = 0;
    if(iPhoneX || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)
        tempheight = 20;
    self.buyView = [[BottumBuyView alloc] initWithFrame:CGRectMake(0, kScreenHeight-60-tempheight, kScreenWidth, 60+tempheight)];
    self.buyView.delegate = self;
    self.buyView.delegate = self;
    [self.view addSubview:self.buyView];
}




#pragma mark ------------------------View Event---------------------------
- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------ 展示物流详情弹出view
- (void)showExpressInfoView:(id)sender
{
    UIView *bv = [[UIView alloc] initWithFrame:self.view.frame];
    bv.alpha = 0.5;
    bv.tag = 112;
    bv.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bv];
    
    self.expressInfoView = [[[NSBundle mainBundle] loadNibNamed:@"ExpressInfoView" owner:self options:nil] lastObject];
    [self.view addSubview:self.expressInfoView];
    self.expressInfoView.delegate = self;
    [self.expressInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(335);
    }];
    self.expressInfoView.backgroundColor = [UIColor whiteColor];
}



#pragma mark ------------------------Delegate-----------------------------
#pragma mark --------- 商品分享按钮
- (void)supply_share_Action
{
    NSLog(@"供应大厅--商品分享按钮");
}

#pragma mark --------- 商品收藏按钮
- (void)supply_love_Action
{
    NSLog(@"供应大厅--商品收藏按钮");
}

//移除物流弹出框
- (void)expressInfoViewDismiss
{
    self.expressInfoView.delegate = nil;
    [self.expressInfoView removeFromSuperview];
    UIView *bv = [self.view viewWithTag:112];
    [bv removeFromSuperview];
}

#pragma mark --------- 查看所有交易评论
- (void)showAllCommentAction
{
    GoodsCommentController *commentCon = [[GoodsCommentController alloc] init];
    [self.navigationController pushViewController:commentCon animated:YES];
}


#pragma mark --------- 进店看看
- (void)enterShopController
{
    NSLog(@"供应大厅--进店看看");
}

#pragma mark --------- 聊一聊
- (void)chat_action
{
    
}

#pragma mark --------- 打电话
- (void)call_action
{
    
}

#pragma mark --------- 购物车
- (void)cart_action
{
    
}

#pragma mark --------- 加入购物车
- (void)addToCart_action
{
    UIView *bv = [[UIView alloc] initWithFrame:self.view.frame];
    bv.alpha = 0.5;
    bv.tag = 112;
    bv.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bv];
    
    NSArray *specarr = [[NSArray alloc] initWithObjects:@"大狗",@"大大大大大大狗",@"大hjhjjjjj狗",@"大狗",@"大狗",@"大大大狗", nil];
    
    self.addCartView = [[[NSBundle mainBundle] loadNibNamed:@"AddToCartView" owner:self options:nil] lastObject];
    [self.addCartView _initCartViewInfo:IMAGE(@"supply_goodsimg") price:@"123.45" msg:@"发到你开那几款和接口很快就回家抗洪晶科科技很快就发商方开始发" specArr:specarr];
    self.addCartView.delegate = self;
    [self.view addSubview:self.addCartView];
    [self.addCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(385);
    }];
    self.addCartView.backgroundColor = [UIColor whiteColor];
}

#pragma mark --------- 立即购买
- (void)buy_action
{
    
}

#pragma mark --------- 确定 加入购物车
- (void)addToCart_Ok:(int)selectedIndex
{
    self.addCartView.delegate = nil;
    [self.addCartView removeFromSuperview];
    UIView *bv = [self.view viewWithTag:112];
    [bv removeFromSuperview];
    
    NSLog(@"选中的规格索引 = %d",selectedIndex);
}

#pragma mark --------- 取消 加入购物车
- (void)addToCart_Cancel
{
    self.addCartView.delegate = nil;
    [self.addCartView removeFromSuperview];
    UIView *bv = [self.view viewWithTag:112];
    [bv removeFromSuperview];
}



@end
