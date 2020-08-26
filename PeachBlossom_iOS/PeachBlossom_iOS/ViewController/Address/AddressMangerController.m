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
@interface AddressMangerController ()
@property (nonatomic,strong)MycommonTableView *addressTable;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation AddressMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"地址管理";
     
    [self _initaddressTable];
    [self.addressTable configureTableAfterRequestTotalData:@[@"",@""]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark ------------------------Init---------------------------------
- (void)_initaddressTable {
    
    self.addressTable=[[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarAndNavigationBarHeight)];
    self.addressTable.cellHeight = 79;
    self.addressTable.noDataLogicModule.nodataAlertTitle=@"您还没有收货地址,请新增地址";
    self.addressTable.backgroundColor = KViewBgColor;
    WEAK_SELF
    [self.addressTable configurecellNibName:@"AddressMangerCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
       
        
    }clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    [self.view addSubview:self.addressTable];
    
}



@end
