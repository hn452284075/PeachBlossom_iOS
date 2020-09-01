//
//  SupplyOrderDetailsVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/9/1.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SupplyOrderDetailsVC.h"
#import "ProcurementCell.h"
#import "MycommonTableView.h"
#import "WaitingPayDetailsVC.h"
@interface SupplyOrderDetailsVC ()
@property (nonatomic,strong)MycommonTableView *listTableView;
@end

@implementation SupplyOrderDetailsVC

-(void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.listTableView];
    [self removeLine];
    [_listTableView configureTableAfterRequestPagingData:@[@{@"status":@"1"},@{@"status":@"2"},@{@"status":@"5"}]];
    [self _requestOrderData];
    if ([self.orderType isEqualToString:@"0"]) {
        
        [self setIsPushPage:YES];
    }else{
        
        for (UISwipeGestureRecognizer *recognizer in [[self view] gestureRecognizers]) {
            [[self view] removeGestureRecognizer:recognizer];
        }
    }
}
#pragma mark ------------------------Api----------------------------------
-(void)_requestOrderData{
 
    
}


#pragma mark ------------------------Page Navigate------------------------
-(void)jumpWaitingPayDetailsVC{
    WaitingPayDetailsVC *vc = [[WaitingPayDetailsVC alloc]init];
    vc.isSupplyOrderPush=YES;
    [self navigatePushViewController:vc animate:YES];

}

#pragma mark ------------------------Getter / Setter----------------------
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-39-kStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        WEAK_SELF
        _listTableView.cellHeightBlock = ^CGFloat(UITableView *tableView, id cellModel) {
            NSDictionary *dic=(NSDictionary *)cellModel;
            if([dic[@"status"]intValue]==5){
                return  218.0f;
            }else{
               return  273.0f;
            }
        };
     
        
        [_listTableView configurecellNibName:@"ProcurementCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
            NSDictionary *dic=(NSDictionary *)cellModel;
            ProcurementCell *orderCell =(ProcurementCell *)cell;
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSLog(@"%@",cellModel);
            [orderCell setDic:dic];
            
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            
            [weak_self jumpWaitingPayDetailsVC];
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
