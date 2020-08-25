//
//  SearchListVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/18.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SearchListVC.h"
#import "MycommonTableView.h"
@interface SearchListVC ()
@property (nonatomic,strong)MycommonTableView *listTableView;
@end

@implementation SearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listTableView];
     [_listTableView configureTableAfterRequestPagingData:@[@"",@"",@"",@"",@"",@""]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.noDataLogicModule.nodataAlertTitle=@"暂无血糖测量方案";
        _listTableView.noDataLogicModule.nodataAlertImage=@"pic-default-01"; _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight = 163.0f;
        
        [_listTableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
        WEAK_SELF
        [_listTableView configurecellNibName:@"SearchCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
           
            
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            
            
        }];
        
        
        [_listTableView headerRreshRequestBlock:^{
          
        }];
        
        
        [_listTableView footerRreshRequestBlock:^{
           
            
        }];
        
        
        
    }
    
    return _listTableView;
}


@end
