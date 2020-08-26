//
//  CollectGoodsVC.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "CollectGoodsVC.h"
#import "MycommonTableView.h"
#import "CollectGoodsCell.h"
@interface CollectGoodsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)MycommonTableView *listTableView;
@end

@implementation CollectGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.listTableView];
    
    [_listTableView configureTableAfterRequestPagingData:@[@"",@""]];
    [self _requestOrderData];
}

#pragma mark ------------------------Api----------------------------------
-(void)_requestOrderData{
 
    
}


 

#pragma mark ------------------------Delegate-----------------------------
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.backgroundColor = KViewBgColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(14, 25, 250, 15)];
    label.text = @"2020-06-17";
    label.font = CUSTOMFONT(15);
    [headerView addSubview:label];
    return headerView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000000001;
    
}
 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectGoodsCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:@"CollectGoodsCell" forIndexPath:indexPath];
    
    return cell;
    
}

#pragma mark ------------------------Getter / Setter----------------------
- (MycommonTableView *)listTableView{
    
    if (!_listTableView) {
        _listTableView  = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kStatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = KViewBgColor;
        _listTableView.rowHeight=129;
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        [_listTableView registerNib:[UINib nibWithNibName:@"CollectGoodsCell" bundle:nil] forCellReuseIdentifier:@"CollectGoodsCell"];
        
        WEAK_SELF
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
