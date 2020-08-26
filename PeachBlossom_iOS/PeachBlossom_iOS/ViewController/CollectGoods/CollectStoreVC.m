//
//  CollectStoreVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CollectStoreVC.h"
#import "MycommonTableView.h"
#import "CollectStoreCell.h"
@interface CollectStoreVC ()
@property (nonatomic,strong)MycommonTableView *listTableView;
@end

@implementation CollectStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"关注店铺";
 
    [self.view addSubview:self.listTableView];
    
    [_listTableView configureTableAfterRequestPagingData:@[@"",@""]];
    
}

 

- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        
        
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight = 95.0f;
        
        
        WEAK_SELF
        [_listTableView configurecellNibName:@"CollectStoreCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
           
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            
            
        }];
        
        
        [_listTableView headerRreshRequestBlock:^{
            weak_self.listTableView.dataLogicModule.currentDataModelArr = @[].mutableCopy;
            weak_self.listTableView.dataLogicModule.requestFromPage=1;
           
        }];
        
        
        [_listTableView footerRreshRequestBlock:^{
            
            
        }];
        
        
        
    }
    
    return _listTableView;
}


@end
