//
//  ShopCartViewController.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/18.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartCell.h"
#import "ShopCartHeaderView.h"
#import "ShopCartManger.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "GoodsModel.h"
#import "ShopCartManger+request.h"
#import "GlobleErrorView.h"

@interface ShopCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *shopCartArray;
@property (nonatomic,strong)ShopCartHeaderView *shopCartHeaderView;

@property (weak, nonatomic) IBOutlet UITableView *shopCartTableView;

@property (nonatomic,strong)UIButton *rightBtn;

@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"购物车";
    
 
    
    [self _init];
    

    [self _initShopCartTableView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [ShopCartManger sharedManager].seletedCount=0;
    [ShopCartManger sharedManager].isSelecteAll=NO;
    _allSeletedBtn.selected = NO;
    self.totalMoney.text = @"总计:￥0.00";
    [self.settlementBtn setTitle:@"结算" forState:UIControlStateNormal];
    WEAK_SELF
    [ self _checkNetWork:^(BOOL isNetWork){
        if (isNetWork) {
           [weak_self _requestData];
        }
        
    }];
  
}


- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
     NSLog(@"%@",NSStringFromCGRect(self.bottomView.frame));
}


#pragma mark ------------------------Init---------------------------------
- (void)_init{

    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    self.rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.rightBtn setTitleColor:KCOLOR_MAIN_TEXT forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)_initShopCartTableView{
    
    self.shopCartTableView.rowHeight = 103;
    self.shopCartTableView.delegate = self;
    self.shopCartTableView.dataSource = self;
    [self.shopCartTableView registerNib:[UINib nibWithNibName:@"ShopCartCell" bundle:nil] forCellReuseIdentifier:@"ShopCartCell"];
    
    
}
#pragma mark ------------------------Private------------------------------
//店铺选中即店铺中的商品都选中
- (void)clickedWhichHeaderViewIsSeleted:(BOOL)isSeleted AndSectionIndex:(NSInteger)index{

    [[ShopCartManger sharedManager]selectStoreAllShopCartGoods:isSeleted AndSectionIndex:index];
    
    [self refreshBottomUI];
    
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:index-2000];
    
    [self.shopCartTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
}


//刷新当前选中的cell
- (void)clickedSeletedLeftBtn:(UITableViewCell *)cell{
    NSIndexPath * indexpath = [self.shopCartTableView indexPathForCell:cell];
    [[ShopCartManger sharedManager]clickSeletedGoods:indexpath];
    
    [self refreshBottomUI];
    [self.shopCartTableView reloadData];
}

//刷新底部UI
- (void)refreshBottomUI{
    //空数据显示view
    if ([ShopCartManger sharedManager].goodsShopCartArray.count == 0) {
        [GlobleErrorView showInContentView:self.shopCartTableView withReloadBlock:^{
            
        } alertTitle:@"您还未添加任何商品" alertImageName:@"空购物车状态"];
        
    }else{
        [GlobleErrorView showLoadingInView:self.shopCartTableView];
    }
    self.allSeletedBtn.selected = [ShopCartManger sharedManager].isSelecteAll;
    self.totalMoney.text = [NSString stringWithFormat:@"总计:￥%.2f",[ShopCartManger sharedManager].totalPrice];
   
    if ([ShopCartManger sharedManager].seletedCount ==0) {
        
        [self.settlementBtn setTitle:@"结算" forState:UIControlStateNormal];
    }else{
         [self.settlementBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",[ShopCartManger sharedManager].seletedCount] forState:UIControlStateNormal];
    }
}

//修改数量
- (void)changeTheShopCount:(UITableViewCell *)cell count:(NSNumber *)count isAdd:(NSString *)addOrSub{
    NSIndexPath * indexpath = [self.shopCartTableView indexPathForCell:cell];
    WEAK_SELF
    [[ShopCartManger sharedManager]changeTheShopIndexPath:indexpath AndModify:count isAdd:addOrSub AddIsSuccess:^(BOOL isSuccess) {
        
        if(isSuccess){
            [weak_self refreshBottomUI];
        }
    }];

}

#pragma mark ------------------------Api----------------------------------
- (void)_requestData {
    WEAK_SELF
    [self showHub];
    self.shopCartArray = [NSMutableArray array];
    [[ShopCartManger sharedManager]ShopCartAllDataBlock:^(BOOL isSuccess, NSMutableArray *array) {
       
        if (isSuccess) {
            [weak_self dissmiss];
            weak_self.shopCartArray = array;
            if (weak_self.shopCartArray.count==0) {
//              weak_self.shopCartTableView.noDataLogicModule.nodataAlertImage = @"空购物车状态";
//                weak_self.shopCartTableView.noDataLogicModule.nodataAlertTitle = @"您还未添加任何商品";
//                weak_self.shopCartTableView.dataLogicModule.currentDataModelArr = [@[]mutableCopy];
                
                [GlobleErrorView showInContentView:weak_self.shopCartTableView withReloadBlock:^{
                
                } alertTitle:@"您还未添加任何商品" alertImageName:@"空购物车状态"];
                
            }else{
            [GlobleErrorView showLoadingInView:weak_self.shopCartTableView];
            [weak_self.shopCartTableView reloadData];
            weak_self.allSeletedBtn.selected = NO;
            [weak_self.settlementBtn setTitle:@"结算" forState:UIControlStateNormal];
            }
        }else{
        
            [weak_self showErrorInfoWithStatus:@"请求失败"];
        }
        
    }];
    

}

//订单结算
- (void)_settlementOrder{
 
    [ShopCartManger sharedManager].seletedCount=0;
    [ShopCartManger sharedManager].isSelecteAll = NO;
    [self _jumpSurePage:[ShopCartManger sharedManager].seletedGoodsStr];

}
#pragma mark ------------------------Page Navigate------------------------
- (void)_jumpSurePage:(NSString *)idStr{

   

}
#pragma mark ------------------------View Event---------------------------
- (void)rightClick:(UIButton *)btn {
    self.rightBtn.selected = !self.rightBtn.selected;
    if (self.rightBtn.selected) {
        self.settlementBtn.selected = YES;
        self.totalMoney.hidden = YES;
        self.freightLabel.hidden = YES;
        
        //是否有效产品的通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:EditorGoodsCenter object:@1];
    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:EditorGoodsCenter object:@0];
        self.settlementBtn.selected = NO;
        self.totalMoney.hidden = NO;
        self.freightLabel.hidden = NO;
    }
    
    [self.shopCartTableView reloadData];
     

}
//结算or删除所选
- (IBAction)settlementClick:(id)sender {
    
    
    
    
    if (self.settlementBtn.selected) {
        if ([ShopCartManger sharedManager].seletedCount==0||self.shopCartArray.count ==0) {
            [self showErrorWithStatus:@"您还未选择宝贝"];
            return;
        }
        WEAK_SELF
        [self showHub];
        [[ShopCartManger sharedManager]deleteSeletedArray:^(BOOL isSuccess) {
            if (isSuccess) {
                [weak_self dissmiss];
                [weak_self refreshBottomUI];
                [weak_self.shopCartTableView reloadData];
            }else{
               [weak_self showErrorInfoWithStatus:@"失败"];
            }
        }];
        
        
    }else{
     
        if ([ShopCartManger sharedManager].seletedCount==0||self.shopCartArray.count ==0) {
            
            
            [self showErrorWithStatus:@"您还未选择宝贝"];
            
    
        }else{
        
            [self _settlementOrder];
            
        }

    }
}

- (IBAction)allSeletedClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[ShopCartManger sharedManager]isSeletedAllGoods:sender.selected];
    [self refreshBottomUI];
    [self.shopCartTableView reloadData];
}


#pragma mark ------------------------Delegate-----------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.shopCartArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.shopCartArray[section] listArr].count;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0000001f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _shopCartHeaderView = BoundNibView(@"ShopCartHeaderView", ShopCartHeaderView);

    _shopCartHeaderView.model = self.shopCartArray[section];
    _shopCartHeaderView.tag = section + 2000;
    WEAK_SELF
    _shopCartHeaderView.headerViewBlock = ^(NSInteger index,BOOL isSeleted){
    
        [weak_self clickedWhichHeaderViewIsSeleted:isSeleted AndSectionIndex:index];
        
    };
    
    return _shopCartHeaderView;
}


 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCartCell *cell = [self.shopCartTableView dequeueReusableCellWithIdentifier:@"ShopCartCell" forIndexPath:indexPath];
    
    cell.model = [self.shopCartArray[indexPath.section] listArr][indexPath.row];
    WEAK_SELF
    cell.seletedBlock = ^(UITableViewCell *cell){
    
        [weak_self clickedSeletedLeftBtn:cell];
        
    };
    
    cell.goodsNumBlock = ^(UITableViewCell *cell,NSNumber*num,NSString *addSub){
    
        [weak_self changeTheShopCount:cell count:num isAdd:addSub];
    };
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    GoodsDetailsController *detailsVC  = [[GoodsDetailsController alloc]init];
//
//    GoodsModel *model = [self.shopCartArray[indexPath.section] listArr][indexPath.row];
//    detailsVC.goodsId = model.productId;
//    [self navigatePushViewController:detailsVC animate:YES];

    
}

//右滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreModel * storeModel = [self.shopCartArray objectAtIndex:indexPath.section];
    GoodsModel *goodsModel = [ storeModel.listArr objectAtIndex:indexPath.row];
    
    
    StoreModel * model = [self.shopCartArray[indexPath.section]listArr][indexPath.row];
    NSMutableArray * ary = [self.shopCartArray[indexPath.section] listArr];
    WEAK_SELF
    [self showHub];
    [[ShopCartManger sharedManager] requestDeleteShopCartGoodsForGoodsIds:goodsModel.productId  deleteShopCartBlock:^(BOOL isDelete) {
        if (isDelete) {
            [weak_self dissmiss];
            [ary removeObject:model];
            if (ary.count == 0) {
                [weak_self.shopCartArray removeObjectAtIndex:indexPath.section];
                [weak_self.shopCartTableView reloadData];
            }else{
                
                [weak_self.shopCartTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                
            }
            
            
            [[ShopCartManger sharedManager]GetTotalBill];
            [weak_self refreshBottomUI];

            
        }else{
            
            [weak_self showErrorInfoWithStatus:@"失败"];
            
        }
        
    }];

    
 


}
//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


 @end
