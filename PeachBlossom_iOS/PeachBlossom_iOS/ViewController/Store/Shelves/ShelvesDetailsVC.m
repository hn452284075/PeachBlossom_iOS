//
//  ShelvesDetailsVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "ShelvesDetailsVC.h"
#import "ShelvesCell.h"
#import "ShelvesHeaderView.h"
#import "MycommonTableView.h"
@interface ShelvesDetailsVC ()
@property (nonatomic,strong)MycommonTableView *listTableView;
@end

@implementation ShelvesDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor  = KViewBgColor;
    [self.view addSubview:self.listTableView];
    
    [_listTableView configureTableAfterRequestPagingData:@[@"",@""]];
    [self _requestOrderData];
}

-(void)_requestOrderData{
    //    NSDictionary *param = @{kRequestPageNumKey :@(self.listTableView.dataLogicModule.requestFromPage),kRequestPageSizeKey:@(kRequestDefaultPageSize),@"patientsId":[UserModel sharedInstance].patientsId,@"status":self.orderType};
    //       WEAK_SELF
    //       [OrderModel getProductListWithParameter:param andHudView:self.navigationController.view withRequestDidFinished:^(NSDictionary * _Nullable results) {
    //           NSLog(@"%@",results);
    //           if (results.count > 0) {
    //               NSDictionary *data = [results objectForKey:@"data"];
    //               NSArray *records = [data objectForKey:@"records"];
    //               [weak_self.listTableView configureTableAfterRequestPagingData:records];
    //           }
    //       }];
    
}

- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-40-kStatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight=158;
        _listTableView.firstSectionHeaderHeight = 153.0f;
        [_listTableView configureFirstSectioHeaderNibName:@"ShelvesHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionHeaderView) {
            
        }];
        
        WEAK_SELF
        [_listTableView configurecellNibName:@"ShelvesCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
           
            
            
            
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
