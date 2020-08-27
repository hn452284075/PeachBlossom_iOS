//
//  SearchViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/18.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "SearchViewController.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
#import "SearchListVC.h"
#import "MycommonTableView.h"
#import "SearchCell.h"
#import "MyCommonCollectionView.h"
#import "AddressCell.h"
#import "EWAddressModel.h"
#import "AddressHeaderView.h"
#import "AddressShowView.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;
@property (nonatomic,strong)MycommonTableView *listTableView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowlayout;
 
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self.view addSubview:self.listTableView];
    

    [_listTableView configureTableAfterRequestPagingData:@[@"",@"",@"",@"",@"",@""]];
 
           
}


#pragma mark ------------------------Init---------------------------------
 
 

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}




#pragma mark ------------------------Private------------------------------
 
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate------------------------

#pragma mark ------------------------View Event---------------------------
- (IBAction)regionClick:(id)sender{

    [[AddressShowView addressManager]show:^(NSString * _Nonnull str) {
        NSLog(@"%@",str);
    }];
}

- (IBAction)goBackClick:(id)sender{
    [self goBack];
}

#pragma mark ------------------------Delegate-----------------------------
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0,133,kScreenWidth, kScreenHeight-133) style:UITableViewStylePlain];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.noDataLogicModule.nodataAlertTitle=@"暂无血糖测量方案";
        _listTableView.noDataLogicModule.nodataAlertImage=@"pic-default-01"; _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.cellHeight = 163.0f;
        
        [_listTableView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellReuseIdentifier:@"SearchCell"];
        WEAK_SELF
        [_listTableView configurecellNibName:@"SearchCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSUInteger index) {
           
            
            
            
        } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
            SearchListVC *vc = [[SearchListVC alloc]init];
            [self  navigatePushViewController:vc animate:YES];
            
        }];
        
        
        [_listTableView headerRreshRequestBlock:^{
          
        }];
        
        
        [_listTableView footerRreshRequestBlock:^{
           
            
        }];
        
        
        
    }
    
    return _listTableView;
}





 
@end
