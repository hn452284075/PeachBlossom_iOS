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
#import "SupplyGoodsCell.h"
#import "GoodsInfoViewController.h"

@interface SupplyViewController ()<UITableViewDelegate,UITableViewDataSource>

//农产品  农资种苗   农机具  三个类别
@property (nonatomic, strong) UIButton *class_btn1;
@property (nonatomic, strong) UIButton *class_btn2;
@property (nonatomic, strong) UIButton *class_btn3;

//选中某一个类别后下方的小图标
@property (nonatomic, strong) UIView   *selectedView;

@property (nonatomic, strong) UITableView *goodsTableview;

@end

@implementation SupplyViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
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
    
    
    //添加下方的uitableview
    self.goodsTableview = [[UITableView alloc] init];
    [self.view addSubview:self.goodsTableview];
    [self.goodsTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(70);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
    }];
    self.goodsTableview.delegate = self;
    self.goodsTableview.dataSource = self;
    self.goodsTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.goodsTableview.tableHeaderView = [self tableHeaderView];
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

#pragma mark ------------------------ 中间部分农产品、农资种苗、农机具点击事件
- (void)classBtnClicked:(id)sender
{
    [self.class_btn1 setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
    [self.class_btn2 setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
    [self.class_btn3 setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
    
    UIButton *btn = (UIButton *)sender;
    [btn setTitleColor:kGetColor(0x47, 0xc6, 0x7c) forState:UIControlStateNormal];
    
    
    switch (btn.tag) {
        case 1:
        {
            self.selectedView.center = CGPointMake(btn.frame.origin.x+btn.frame.size.width-25, btn.center.y+15);
        }
            break;
        case 2:
        {
            self.selectedView.center = CGPointMake(btn.center.x, btn.center.y+15);
        }
            break;
        case 3:
        {
            self.selectedView.center = CGPointMake(btn.frame.origin.x+25, btn.center.y+15);
        }
            break;
        default:
            break;
    }
}

#pragma mark ------------------------ 切换产地按钮点击事件
- (void)placeBtnClicked:(id)sender
{
    

}


#pragma mark ------------------------ 种类分类按钮点击事件
- (void)productClassViewClicked:(id)sender
{
    
}

#pragma mark ------------------------Init---------------------------------
- (UIView *)tableHeaderView
{
    //标题
    UIView *hview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 510)];
    hview.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
    UIImageView *topImg = [[UIImageView alloc] init];
    [hview addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hview.mas_top);
        make.left.equalTo(hview.mas_left);
        make.right.equalTo(hview.mas_right);
        make.height.mas_equalTo(198.5);
    }];
    topImg.image = IMAGE(@"topImage");
        
    //搜索框
    UIView *seachView = [[UIView alloc] init];
    [hview addSubview:seachView];
    [seachView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hview.mas_top).offset(11.5);
        make.left.equalTo(hview.mas_left).offset(14);
        make.right.equalTo(hview.mas_right).offset(-14);
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
    [hview addSubview:adBtn];
    [adBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seachView.mas_bottom).offset(10);
        make.left.equalTo(hview.mas_left).offset(14);
        make.right.equalTo(hview.mas_right).offset(-14);
        make.height.mas_equalTo(120);
    }];
    [adBtn setBackgroundImage:IMAGE(@"supply_banner") forState:UIControlStateNormal];
    
    //中间部分 产品种类view
    UIView *productView = [[UIView alloc] init];
    [hview addSubview:productView];
    [productView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hview.mas_top).offset(251.5-70);
        make.left.equalTo(hview.mas_left).offset(14);
        make.right.equalTo(hview.mas_right).offset(-14);
        make.height.mas_equalTo(228);
    }];
    productView.backgroundColor = [UIColor whiteColor];
    
    self.class_btn1 = [self getCustomBtn:self.class_btn1 title:@"农产品" tag:1];
    self.class_btn2 = [self getCustomBtn:self.class_btn2 title:@"农资种苗" tag:2];
    self.class_btn3 = [self getCustomBtn:self.class_btn3 title:@"农机具" tag:3];
    
    [productView addSubview:self.class_btn1];
    [self.class_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(productView.mas_top).offset(13.5);
        make.left.equalTo(productView.mas_left);
        make.width.mas_equalTo(productView.mas_width).dividedBy(3);
        make.height.mas_equalTo(16);
    }];
    
    [productView addSubview:self.class_btn2];
    [self.class_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(hview.mas_centerX);
        make.centerY.equalTo(self.class_btn1);
        make.width.mas_equalTo(productView.mas_width).dividedBy(3);
        make.height.mas_equalTo(16);
    }];
    
    [productView addSubview:self.class_btn3];
    [self.class_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.class_btn1);
        make.right.equalTo(productView.mas_right);
        make.width.mas_equalTo(productView.mas_width).dividedBy(3);
        make.height.mas_equalTo(16);
    }];
    
    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 29, 2)];
    self.selectedView.backgroundColor = kGetColor(0x47, 0xc6, 0x7c);
    [productView addSubview:self.selectedView];
    
    self.class_btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.class_btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.class_btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.class_btn1 sendActionsForControlEvents:UIControlEventTouchUpInside];
    });
    
    
    //中间产品分类
    NSMutableArray *classImg_arr1 = [[NSMutableArray alloc] init];
    for(int i=0;i<8;i++)
    {
        [classImg_arr1 addObject:@"home-icon_1"];
    }
    NSMutableArray *className_arr1 = [[NSMutableArray alloc] init];
    for(int i=0;i<8;i++)
    {
        [className_arr1 addObject:@"苹果"];
    }
    NSMutableArray *classView_arr1 = [[NSMutableArray alloc] init];
    for(int i=0;i<8;i++)
    {
        UIView *view = [self getCustomClassView:[UIImage imageNamed:[classImg_arr1 objectAtIndex:i]] tag:i+100 title:[className_arr1 objectAtIndex:i]];
        [classView_arr1 addObject:view];
        [productView addSubview:view];
    }
    //水平方向宽度固定等间隔
    int row = (int)classView_arr1.count / 5;
    if(classView_arr1.count % 5 != 0)
        row +=1;
    UIView *v = [classView_arr1 objectAtIndex:0];
    int x = 0;
    int y = 40;
    int w = v.frame.size.width;
    int h = v.frame.size.height;
    for(int i=0;i<row;i++)
    {
        int temp = 0;
        for(int j=5*i;j<classView_arr1.count;j++)
        {
            UIView *v = [classView_arr1 objectAtIndex:j];
            v.frame = CGRectMake(x+w*temp++, y+h*i, w, h);
            if(temp > 5)
                break;
        }
    }
    
    //产地
    UIView *placeView = [[UIView alloc] init];
    [hview addSubview:placeView];
    [placeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(productView.mas_bottom).offset(18.5);
        make.left.equalTo(hview.mas_left).offset(14);
        make.right.equalTo(hview.mas_right).offset(-14);
        make.height.mas_equalTo(36);
    }];
    placeView.backgroundColor = [UIColor whiteColor];
    
    UILabel *placeLabel = [[UILabel alloc] init];
    [placeView addSubview:placeLabel];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeView.mas_centerY);
        make.left.equalTo(placeView.mas_left).offset(14);
    }];
    placeLabel.text = @"产地";
    placeLabel.font = [UIFont boldSystemFontOfSize:16];
    placeLabel.textColor = kGetColor(0x22, 0x22, 0x22);
    
    NSArray *placeArr = [[NSArray alloc] initWithObjects:@"附近",@"湖南",@"湖北",@"广西",@"山西",@"河北", nil];
    NSMutableArray *placeItemArray = [[NSMutableArray alloc] init];
    for(int i=0;i<placeArr.count;i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:[placeArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:kGetColor(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [placeView addSubview:btn];
        [placeItemArray addObject:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(placeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [placeItemArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:(kScreenWidth-60-28)/6 leadSpacing:60 tailSpacing:2];
    [placeItemArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeView.mas_centerY);
    }];
    
    //最新货源
    UILabel *newGoodsLab = [[UILabel alloc] init];
    [hview addSubview:newGoodsLab];
    [newGoodsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeView.mas_bottom).offset(17);
        make.centerX.equalTo(hview.mas_centerX);
        make.height.mas_equalTo(16);
    }];
    newGoodsLab.text = @"最新货源";
    newGoodsLab.font = [UIFont boldSystemFontOfSize:16];
    newGoodsLab.textColor = kGetColor(0x22, 0x22, 0x22);
    
    return hview;
}
 
#pragma mark ------------------------Private------------------------------
- (UIButton *)getCustomBtn:(UIButton *)btn title:(NSString *)string tag:(int)tag
{
    btn = [[UIButton alloc] init];
    btn.tag = tag;
    [btn setTitle:string forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(classBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:kGetColor(0x22, 0x22, 0x22) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    return btn;
}

- (UIView *)getCustomClassView:(UIImage *)img tag:(int)tag title:(NSString *)string
{
    int w = (kScreenWidth-28)/5;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, w+20)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w, w)];
    [btn setImage:img forState:UIControlStateNormal];
    btn.tag = tag;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(productClassViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, w-2, w, 14)];
    lab.text = string;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    
    return view;
}
 
#pragma mark ------------------------Api----------------------------------

#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------Delegate-----------------------------



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    GoodsInfoViewController *infoCon = [[GoodsInfoViewController alloc] init];    
    [self navigatePushViewController:infoCon animate:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"supplygoodscell";
    SupplyGoodsCell *cell = (SupplyGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SupplyGoodsCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

@end
