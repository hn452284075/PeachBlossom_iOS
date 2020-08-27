//
//  ProcurementDetailsVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "ProcurementDetailsVC.h"
#import "ProcurementCell.h"
#import "MycommonTableView.h"
@interface ProcurementDetailsVC ()
@property (nonatomic,strong)MycommonTableView *listTableView;
@end

@implementation ProcurementDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.listTableView];
    
    [_listTableView configureTableAfterRequestPagingData:@[@"",@""]];
    [self _requestOrderData];
}
#pragma mark ------------------------Api----------------------------------
-(void)_requestOrderData{
 
    
}
#pragma mark ------------------------Getter / Setter----------------------
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-40) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight = 273.0f;
        
     
        WEAK_SELF
        [_listTableView configurecellNibName:@"ProcurementCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
            ProcurementCell *orderCell =(ProcurementCell *)cell;
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSLog(@"%@",cellModel);
            [orderCell setDic:@{@"status":@"1"}];
            
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            
            
        }];
        
        
        [_listTableView headerRreshRequestBlock:^{
            weak_self.listTableView.dataLogicModule.currentDataModelArr = @[].mutableCopy;
            weak_self.listTableView.dataLogicModule.requestFromPage=1;
            [weak_self _requestOrderData];
        }];
        
        
        [_listTableView footerRreshRequestBlock:^{
            [weak_self _requestOrderData];
            
        }];
        
        
        
    }
    
    return _listTableView;
}


@end
