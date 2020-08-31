//
//  ShopCartManger.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreModel.h"
#import <UIKit/UIKit.h>
typedef void(^ShopCartAllDataBlock)(BOOL isSuccess, NSMutableArray *array);
typedef void(^ShopCartDelegateDataBlock)(BOOL isSuccess);
typedef void(^AddAndSubtractIsSuccess)(BOOL isSuccess);
typedef void(^GetShopCartCountBlock)(NSInteger count);
@interface ShopCartManger : NSObject

+ (instancetype)sharedManager;

/**
 *  请求购物车数据
 */
- (void)ShopCartAllDataBlock:(ShopCartAllDataBlock)shopCartAllDataBlock;

/**
 *  购物车店铺商品数组
 */
@property (nonatomic,strong)NSMutableArray *goodsShopCartArray;

/**
 *获取购物车选中的商品总价
 */
@property (nonatomic,assign)CGFloat totalPrice;
/**
 *获取购物车选中的商品个数
 */
@property (nonatomic, assign)NSInteger seletedCount;
/**
 *获取购物车选中的商品个数
 */
//@property (nonatomic, assign)NSInteger totalCount;

/**
 *  是否全选
 */
@property (nonatomic,assign)BOOL isSelecteAll;
/**
 *  所有勾选的放入一个数组
 */
@property (nonatomic, strong)NSMutableArray *selectedArray;
/**
 *  所有勾选的产品ID
 */
@property (nonatomic, strong) NSMutableString *seletedGoodsStr ;

/**
 *  店铺全选或取消
 */
- (void)selectStoreAllShopCartGoods:(BOOL)isSeleted AndSectionIndex:(NSInteger)index;
/**
 *  所有商品全选的方法
 */
- (void)isSeletedAllGoods:(BOOL)isSeleted;

//- (void)requestTotalCount:(GetShopCartCountBlock)getShopCartCountBlock;

/**
 *  单击选中某个产品
 */
- (void)clickSeletedGoods:(NSIndexPath *)indexpath;

//计算选中的
- (void)GetTotalBill;

/**
 *  修改某个产品的数量
 */
- (void)changeTheShopIndexPath:(NSIndexPath *)indexpath AndModify:(NSNumber *)count  isAdd:(NSString *)isAdd AddIsSuccess:(AddAndSubtractIsSuccess)isSuccess;

/**
 *  删除所选的
 */
- (void)deleteSeletedArray:(ShopCartDelegateDataBlock)shopCartDelegateDataBlock;





@end
