//
//  ShopCartManger.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ShopCartManger.h"
#import "StoreModel.h"
#import "GoodsModel.h"
#import "ShopCartManger+request.h"
#import "BaseLoadingView.h"
static ShopCartManger *_shopCartManger = nil;
@implementation ShopCartManger
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shopCartManger = [[ShopCartManger alloc] init];
        
    });
    return _shopCartManger;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self _initRequest];
        
    }
    return self;
}

//- (void)requestTotalCount:(GetShopCartCountBlock)getShopCartCountBlock
//{

//    NSArray *arr= @[@{@"storeTitle":@"卒子科技",@"listArr":@[@{@"goodsId":@"10",@"desc":@"测试商品1",@"goodsName":@"蔬菜",@"goodsNumber":@1,@"goodsOriginalPrice":@"20000",@"goodsImg":@"http://img5q.duitang.com/uploads/item/201208/22/20120822162653_sNiFT.thumb.224_0.jpeg",@"isValid":@1},@{@"goodsId":@"11",@"desc":@"测试商品2",@"goodsName":@"蔬菜机",@"goodsNumber":@1,@"goodsOriginalPrice":@"40000",@"goodsImg":@"http://img5q.duitang.com/uploads/item/201208/22/20120822162653_sNiFT.thumb.224_0.jpeg",@"isValid":@1}]},@{@"storeTitle":@"卒子科技2",@"listArr":@[@{@"goodsId":@"14",@"desc":@"测试商品1",@"goodsName":@"蔬菜",@"goodsNumber":@1,@"goodsOriginalPrice":@"20000",@"goodsImg":@"http://img5q.duitang.com/uploads/item/201208/22/20120822162653_sNiFT.thumb.224_0.jpeg",@"isValid":@1},@{@"goodsId":@"15",@"desc":@"测试商品2",@"goodsName":@"蔬菜机",@"goodsNumber":@1,@"goodsOriginalPrice":@"10000",@"goodsImg":@"http://img5q.duitang.com/uploads/item/201208/22/20120822162653_sNiFT.thumb.224_0.jpeg",@"isValid":@0}]}];
//    
//    self.goodsShopCartArray = [NSMutableArray array];
//    self.goodsShopCartArray = [StoreModel objectStoreModelWithStoreArr:arr];
   
    
//    WEAK_SELF
//    [self ShopCartAllDataBlock:^(BOOL isSuccess, NSMutableArray *array) {
//        
//        if (isSuccess) {
//            
//            NSMutableArray *totalGoodArr = [NSMutableArray array];
//            for (StoreModel *model in weak_self.goodsShopCartArray) {
//                
//                for (GoodsModel *goodsModel in model.listArr) {
//                    [totalGoodArr addObject:goodsModel];
//                }
//                
//            }
//            
//            getShopCartCountBlock(totalGoodArr.count);
//            
//        }else{
//            getShopCartCountBlock(0);
//        }
//    }];
    
 


//}




/**
 *  请求购物车数据
 */
- (void)ShopCartAllDataBlock:(ShopCartAllDataBlock)shopCartAllDataBlock{

    [self requestShopCartAllData:^(BOOL isSuccess) {

        if (isSuccess) {

            shopCartAllDataBlock(YES,self.goodsShopCartArray);
        }else{

            shopCartAllDataBlock(NO,self.goodsShopCartArray);
        }

    }];
    
    
}

/**
 *  店铺全选或取消
 */
- (void)selectStoreAllShopCartGoods:(BOOL)isSeleted AndSectionIndex:(NSInteger)index {

    NSInteger sectionIndex = index - 2000;
    StoreModel * model = self.goodsShopCartArray[sectionIndex];
    model.isChecked = isSeleted;
    NSMutableArray * tempAry = [self.goodsShopCartArray[sectionIndex]listArr];
    for (int i = 0; i < tempAry.count; i++) {
        GoodsModel * goodsModel = tempAry[i];
        goodsModel.selected = isSeleted;
    }

    [self checkShopState];
}


#pragma mark -- 公共方法
//选中商品或者选中店铺都会走这个公共方法。在这里判断选中的店铺数量还不是和数据源数组数量相等。一样的话就全选，否则相反。
- (void)checkShopState{
    NSInteger totalSelected = 0;
    for (int i = 0; i < self.goodsShopCartArray.count; i++) {
        StoreModel * model = self.goodsShopCartArray[i];
        if (model.isChecked) {
            totalSelected++;
        }
    }
    if (totalSelected == self.goodsShopCartArray.count) {
        self.isSelecteAll = YES;
    }else{
        self.isSelecteAll = NO;
    }
    
    
    [self GetTotalBill];//求和
    
    
}

//求得选中的总共费用
- (void)GetTotalBill{
    self.selectedArray  = [NSMutableArray array];
    float totalMoney = 0.00;
   self.seletedGoodsStr= [[NSMutableString alloc] init];
    for (int i = 0; i < self.goodsShopCartArray.count; i++) {
        StoreModel * model = self.goodsShopCartArray[i];
        for (int j = 0; j < model.listArr.count; j++) {
            GoodsModel *goodsModel = model.listArr[j];
            if (goodsModel.selected) {
                //保存model。如果是结算，传递选中商品，确认订单页面展示。如果是删除，根据此数组，拿到商品ID，用来删除。
                [_selectedArray addObject:goodsModel];
                if (_selectedArray.count==1) {
                    [self.seletedGoodsStr appendString:goodsModel.productId];
                }else{
                   [self.seletedGoodsStr appendString:[NSString stringWithFormat:@",%@",goodsModel.productId]];
                }
                
                totalMoney += [goodsModel.goodsOriginalPrice floatValue] * [goodsModel.goodsNumber intValue];
                
                
            }
        }
    }
    if (self.goodsShopCartArray.count == 0) {
        self.isSelecteAll = NO;
       
    }
    
    JLog(@"compentStr:%@",self.seletedGoodsStr);
    self.totalPrice = totalMoney;
    self.seletedCount = _selectedArray.count;
 
}



/**
 *  所有商品全选的方法
 */
- (void)isSeletedAllGoods:(BOOL)isSeleted {
    
    self.isSelecteAll = isSeleted;
    for (int i = 0; i < self.goodsShopCartArray.count; i++) {
        StoreModel * model = self.goodsShopCartArray[i];
        model.isChecked = isSeleted;
        for (int j = 0; j < model.listArr.count; j++) {
            GoodsModel *goodModel = model.listArr[j];
            goodModel.selected = isSeleted;
        }
    }
    
    [self GetTotalBill];//求和

}
/**
 *  单击选中某个产品
 */

- (void)clickSeletedGoods:(NSIndexPath *)indexpath {

    StoreModel * shopCarModel = self.goodsShopCartArray[indexpath.section];//当前选中的商品对应的店铺的模型
    GoodsModel * model = shopCarModel.listArr[indexpath.row];
    model.selected = !model.selected;
    NSInteger seletedCount = 0;
    for (int i = 0; i < shopCarModel.listArr.count; i++) {
        GoodsModel * shopModel = shopCarModel.listArr[i];
        if (shopModel.selected) {
            seletedCount++;
        }
    }
    StoreModel * sectionModel = self.goodsShopCartArray[indexpath.section];
    //店铺模型中选中的数量等于seletedCount ，说明店铺产品的全选
    sectionModel.isChecked = (seletedCount == shopCarModel.listArr.count);
    
    [self checkShopState];
    
 
}


/**
 *  修改某个产品的数量
 */
- (void)changeTheShopIndexPath:(NSIndexPath *)indexpath AndModify:(NSNumber *)count  isAdd:(NSString *)isAdd AddIsSuccess:(AddAndSubtractIsSuccess)isSuccess{
    
    
    //当前点击选中的商品对应的店铺的模型
    StoreModel * shopCarModel = self.goodsShopCartArray[indexpath.section];
    GoodsModel * model = shopCarModel.listArr[indexpath.row];
 
    
    //先写死假数据
    model.goodsNumber = count;
    [self GetTotalBill];
    isSuccess(YES);
    WEAK_SELF
//    [self requestAdjustShopCartGoodsDataOfGoodsId:model.productId IsAdd:isAdd adjustShopCartBlock:^(BOOL isAdjust,NSString *status) {
//
//        if (isAdjust) {
//
//            model.goodsNumber = count;
//            [weak_self GetTotalBill];
//            isSuccess(YES);
//        }else{
//            isSuccess(NO);
//
//            [[BaseLoadingView sharedManager]showErrorWithStatus:status];
//            return;
//        }
//    }];
    
    
}


/**
 *  删除所选的
 */
- (void)deleteSeletedArray:(ShopCartDelegateDataBlock)shopCartDelegateDataBlock{
 
    
    NSMutableArray *storeTempArr = [[NSMutableArray alloc] init];
    for (StoreModel *storeModel in self.goodsShopCartArray)
    {
        if (storeModel.isChecked)
        {
            [storeTempArr addObject:storeModel];
        }else{
            NSMutableArray *goodsTempArr = [[NSMutableArray alloc] init];
            for (GoodsModel *goodsModel in storeModel.listArr)
            {
                if (goodsModel.selected)
                {
                    [goodsTempArr addObject:goodsModel];
                }
            }
            if (goodsTempArr.count!=0)
            {
                [storeModel.listArr removeObjectsInArray:goodsTempArr];
            }
        }
    }
    //全选删除
    WEAK_SELF
    if (self.isSelecteAll ==YES) {
  
        [self requestClearShopCartData:^(BOOL isClear) {
            
            if (isClear) {
                
      
                [weak_self.goodsShopCartArray removeObjectsInArray:storeTempArr];
                
                [weak_self GetTotalBill];
                shopCartDelegateDataBlock(YES);
            }else{
            
               shopCartDelegateDataBlock(NO);
                
            }
        }];
    }else{
    
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (GoodsModel *model in self.selectedArray) {
            [arr addObject:model.productId];
        }
        NSString *string = [arr componentsJoinedByString:@","];
        [self requestDeleteShopCartGoodsForGoodsIds:string deleteShopCartBlock:^(BOOL isDelete) {
            if (isDelete) {
                
                
                [weak_self.goodsShopCartArray removeObjectsInArray:storeTempArr];
                
                [weak_self GetTotalBill];
                shopCartDelegateDataBlock(YES);
            }else{
                
                shopCartDelegateDataBlock(NO);
                
            }

        }];
            
        
        
    }
   
}

@end
