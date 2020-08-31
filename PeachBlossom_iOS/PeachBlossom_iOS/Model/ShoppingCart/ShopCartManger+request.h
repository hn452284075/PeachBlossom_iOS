//
//  ShopCartManger+request.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ShopCartManger.h"
#import "StoreModel.h"

typedef void(^JoinShopCartBlock)(BOOL isSuccess ,NSString *statusStr);

typedef void(^RequestShopCartBlock)(BOOL isSuccess);

typedef void(^ClearShopCartBlock)(BOOL isClear);

typedef void(^DeleteShopCartBlock)(BOOL isDelete);

typedef void(^AdjustShopCartBlock)(BOOL isAdjust,NSString *statusStr);

@interface ShopCartManger (request)

/**
 *  详情添加购物车数据
 */
- (void)requestJoinShopCartData:(NSString *)goodsId
                     AndisLease:(BOOL)lease
           requestShopCartBlock:(JoinShopCartBlock)requestShopCartBlock;

/**
 *  添加购物车数据
 */
- (void)requestJoinShopCartData:(NSString *)goodsId
           requestShopCartBlock:(JoinShopCartBlock)requestShopCartBlock;

/**
 *  请求购物车数据
 */
- (void)requestShopCartAllData:(RequestShopCartBlock)requestShopCartBlock;

/**
 *  清除服务器购物车
 */
- (void)requestClearShopCartData:(ClearShopCartBlock)clearShopCartBlock;

/**
 *  删除购物车商品
 */
- (void)requestDeleteShopCartGoodsForGoodsIds:(NSString *)goodsIds
                                             deleteShopCartBlock:(DeleteShopCartBlock)deleteShopCartBlock;

/**
 *  调整购物车数量
 */
- (void)requestAdjustShopCartGoodsDataOfGoodsId:(NSString *)goodsId
                                                                            IsAdd:(NSString *)isAdd
                                                    adjustShopCartBlock:(AdjustShopCartBlock)adjustShopCartBlock;


@end
