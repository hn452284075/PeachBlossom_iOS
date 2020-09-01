//
//  SetPriceViewController.m
//  PeachBlossom_iOS
//
//  Created by rover on 2020/9/1.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SetPriceViewController.h"
#import "SetPriceTableViewCell.h"
#import "PriceModel.h"

@interface SetPriceViewController ()<UITableViewDelegate,UITableViewDataSource,SetPriceDelegate>

@property (nonatomic, strong) UIView        *topView;
@property (nonatomic, strong) UITableView   *tablview;
@property (nonatomic, strong) NSMutableArray    *priceArray;

@end

@implementation SetPriceViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceArray = [[NSMutableArray alloc] init];
    PriceModel *pm = [[PriceModel alloc] init];
    pm.priceSpec = @"规格1";
    pm.pricevalue = @"100";
    
    self.view.backgroundColor = kGetColor(0xf7, 0xf7, 0xf7);
    
    //顶部view
    [self _initTopView];
    
    //tableview
    self.tablview = [[UITableView alloc] init];
    [self.view addSubview:self.tablview];
    [self.tablview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    self.tablview.tableFooterView = [[UIView alloc] init];
    self.tablview.delegate = self;
    self.tablview.dataSource = self;
}

#pragma mark ------------------------Init---------------------------------
- (void)_initTopView
{
    int iphonex_height = 0;
    if(IS_Iphone_Series)
        iphonex_height = 20;
        
    UIView *topImg = [[UIView alloc] init];
    [self.view addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(66+iphonex_height);
    }];
    topImg.backgroundColor = kGetColor(0xff, 0xff, 0xff);
    
    UILabel *titleLab = [[UILabel alloc] init];
    [topImg addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topImg.mas_bottom).offset(-14);
        make.centerX.equalTo(topImg.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"设置价格";
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = kGetColor(0x22, 0x22, 0x22);
    
    //返回箭头
    UIButton *backBtn = [[UIButton alloc] init];
    [topImg addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab.mas_centerY);
        make.left.equalTo(topImg.mas_left).offset(14);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    [backBtn setBackgroundImage:IMAGE(@"返回") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backFrontController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.topView = topImg;
}

 
#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
#pragma mark ------------------------ 返回上级页面
- (void)backFrontController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------Delegate-----------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    return 50.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"setpricecell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
        
        SetPriceTableViewCell *priceview = [[SetPriceTableViewCell alloc] init];
        priceview.delegate = self;
        priceview.tag = 100;
        [cell addSubview:priceview];
        [priceview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top);
            make.left.equalTo(cell.mas_left);
            make.right.equalTo(cell.mas_right);
            make.height.mas_equalTo(50);
        }];
    }
    
    SetPriceTableViewCell *priceview = (SetPriceTableViewCell *)[cell viewWithTag:100];
    
    if(indexPath.row == 0)
    {
        [priceview configCellTitle:@"计量单位"
                    actionImg:@""
                     f1String:@""
              f1DefaultString:@"斤"
                     f2String:@""
              f2DefaultString:@""
                    msgString:@""];
        
        [priceview configCellTitleShow:YES filed1:YES filed2:NO msglab:NO arrowImg:YES];
    }
    else if(indexPath.row == 1)
    {
        [priceview configCellTitle:@"起批量"
                    actionImg:@""
                     f1String:@""
              f1DefaultString:@"最低起批量"
                     f2String:@""
              f2DefaultString:@""
                    msgString:@"斤/起"];
        
        [priceview configCellTitleShow:YES filed1:YES filed2:NO msglab:YES arrowImg:YES];
    }
    else if(indexPath.row == 2)
    {
        [priceview configCellTitle:@"规格及价格"
                    actionImg:@""
                     f1String:@""
              f1DefaultString:@""
                     f2String:@""
              f2DefaultString:@""
                    msgString:@""];
        
        [priceview configCellTitleShow:YES filed1:NO filed2:NO msglab:NO arrowImg:NO];
    }
    
    
    
    return cell;
}

- (void)addOrSubFunction:(int)flag
{
    
}



#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end
