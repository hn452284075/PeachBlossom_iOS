//
//  AddressMangerController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "AddressMangerController.h"
#import "MycommonTableView.h"
#import "AddressMangerCell.h"
#import "ZZAddressController.h"
@interface AddressMangerController ()
@property (nonatomic,strong)MycommonTableView *addressTable;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation AddressMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"收货地址";
     
    [self _initaddressTable];
    [self.addressTable configureTableAfterRequestTotalData:@[]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark ------------------------Init---------------------------------
- (void)_initaddressTable {
    
    self.addressTable=[[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0.5, kScreenWidth, kScreenHeight-kStatusBarAndNavigationBarHeight-0.5)];
    self.addressTable.cellHeight = 79;
    self.addressTable.noDataLogicModule.nodataAlertTitle=@"您还没有收货地址噢";
    self.addressTable.noDataLogicModule.nodataAlertImage=@"addressDefault";
    self.addressTable.backgroundColor = KViewBgColor;
    WEAK_SELF
    [self.addressTable configurecellNibName:@"AddressMangerCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
       
        
    }clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    [self.view addSubview:self.addressTable];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight-kStatusBarAndNavigationBarHeight-61, kScreenWidth, 61)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addBtn.frame = CGRectMake(15, 10.5, kScreenWidth-30, 40);
    [addBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    addBtn.titleLabel.font=CUSTOMFONT(14);
    addBtn.layer.cornerRadius=3;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setBackgroundColor:KCOLOR_Main];
    [bottomView addSubview:addBtn];
}

-(void)addBtnClick{
    ZZAddressController *vc = [[ZZAddressController alloc]init];
    [self navigatePushViewController:vc animate:YES];

}

@end
