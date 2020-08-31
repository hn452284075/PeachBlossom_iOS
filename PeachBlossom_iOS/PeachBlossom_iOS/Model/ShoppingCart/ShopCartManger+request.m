//
//  ShopCartManger+request.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "ShopCartManger+request.h"
#import "GlobeMaco.h"
#import "AFNHttpRequestOPManager.h"
@implementation ShopCartManger (request)
/**
 *  详情添加购物车数据
 */
- (void)requestJoinShopCartData:(NSString *)goodsId
                     AndisLease:(BOOL)lease
           requestShopCartBlock:(JoinShopCartBlock)requestShopCartBlock{
    
    NSString *is_rented;
    if (lease) {
        is_rented = @"0";
    }else{
        is_rented = @"1";
        
    }
    
  
    
    NSDictionary  *requestParam  = @{@"module":@"cart",@"act":@"addtocart",@"goods_id":goodsId,@"num":@"1",@"buyer_id":@"",@"is_rented":@""};
    
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
        
        if ([resultDic[@"errcode"] integerValue]==200) {
            
            requestShopCartBlock(YES,resultDic[@"msg"]);
            
        }else{
            requestShopCartBlock(NO,resultDic[@"msg"]);
        }
        
    }];
    
}

/**
 *  添加购物车数据
 */
- (void)requestJoinShopCartData:(NSString *)goodsId
           requestShopCartBlock:(JoinShopCartBlock)requestShopCartBlock{

 
    
     NSDictionary  *requestParam  = @{@"module":@"cart",@"act":@"addtocart",@"goods_id":goodsId,@"num":@"1",@"buyer_id":@"",@"is_rented":@"0"};
    
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
        
        if ([resultDic[@"errcode"] integerValue]==200) {
            
            requestShopCartBlock(YES,resultDic[@"msg"]);

        }else{
            requestShopCartBlock(NO,resultDic[@"msg"]);
        }
        
    }];

}
/**
 *  请求购物车数据
 */
- (void)requestShopCartAllData:(RequestShopCartBlock)requestShopCartBlock{
    
 
    NSDictionary  *requestParam  = @{@"module":@"cart",@"act":@"cartlist",@"extra":@"view",@"buyer_id":@""};
   self.goodsShopCartArray = [NSMutableArray array];
   
    NSArray *arr = @[@{@"seller_name":@"张三水果店",@"avatar":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598851146867&di=a277290994a9735079d5fdcdd6cbcf32&imgtype=0&src=http%3A%2F%2Fimg1.touxiang.cn%2Fuploads%2F20120914%2F14-014209_385.jpg",@"storeId":@"1",@"goods_list":@[@{@"goods_thumb":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598852731130&di=ba08417405760b2daa899da8ba08b13f&imgtype=0&src=http%3A%2F%2Fpic.ikafan.com%2Fimgp%2FL3Byb3h5L2h0dHAvaW1hZ2UzNS4zNjBkb2MuY29tL0Rvd25sb2FkSW1nLzIwMTEvMDkvMDExNC8xNjg0NjQxNl8zOC5qcGc%3D.jpg",@"goods_name":@"烟台大苹果，甘甜可口，条红",@"special_price":@"21",@"goods_num":@1}]},@{@"seller_name":@"王五蔬菜店",@"avatar":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598851146867&di=a277290994a9735079d5fdcdd6cbcf32&imgtype=0&src=http%3A%2F%2Fimg1.touxiang.cn%2Fuploads%2F20120914%2F14-014209_385.jpg",@"storeId":@"2",@"goods_list":@[@{@"goods_thumb":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598852731130&di=ba08417405760b2daa899da8ba08b13f&imgtype=0&src=http%3A%2F%2Fpic.ikafan.com%2Fimgp%2FL3Byb3h5L2h0dHAvaW1hZ2UzNS4zNjBkb2MuY29tL0Rvd25sb2FkSW1nLzIwMTEvMDkvMDExNC8xNjg0NjQxNl8zOC5qcGc%3D.jpg",@"goods_name":@"烟台大苹果，甘甜可口，条红",@"special_price":@"10",@"goods_num":@1}]}];
    self.goodsShopCartArray = [StoreModel objectStoreModelWithStoreArr:arr];
   requestShopCartBlock(YES);
    WEAK_SELF
//    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
//
//        if ([resultDic[@"errcode"] integerValue]==200) {
//
//            NSLog(@"%@",resultDic);
//            weak_self.goodsShopCartArray = [StoreModel objectStoreModelWithStoreArr:resultDic[@"data"][@"seller_list"]];
//            requestShopCartBlock(YES);
//        }else{
//            requestShopCartBlock(NO);
//        }
//
//    }];


}

/**
 *  清除服务器购物车
 */
- (void)requestClearShopCartData:(ClearShopCartBlock)clearShopCartBlock{

    NSDictionary  *requestParam  = @{@"module":@"cart",@"act":@"emptycart",@"buyer_id":@""};
 
 
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
        
        if ([resultDic[@"errcode"] integerValue]==200) {
            
            NSLog(@"%@",resultDic);
          
            clearShopCartBlock(YES);
        }else{
            clearShopCartBlock(NO);
        }
        
    }];
    


}

/**
 *  删除购物车商品
 */
- (void)requestDeleteShopCartGoodsForGoodsIds:(NSString *)goodsIds
                          deleteShopCartBlock:(DeleteShopCartBlock)deleteShopCartBlock{

    NSDictionary  *requestParam  = @{@"module":@"cart",@"act":@"dropcart",@"buyer_id":@"",@"goods_ids":goodsIds};
    
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
        
        if ([resultDic[@"errcode"] integerValue]==200) {
            
            
            deleteShopCartBlock(YES);
        }else{
            deleteShopCartBlock(NO);
        }
        
    }];


}

/**
 *  调整购物车数量
 */
- (void)requestAdjustShopCartGoodsDataOfGoodsId:(NSString *)goodsId
                                          IsAdd:(NSString *)isAdd
                            adjustShopCartBlock:(AdjustShopCartBlock)adjustShopCartBlock{
    
    
    NSDictionary  *requestParam  = @{@"module":@"cart",@"act":@"plusminus",@"do":isAdd,@"buyer_id":@"",@"goods_id":goodsId};
    
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
        
        if ([resultDic[@"errcode"] integerValue]==200) {
            
 
            adjustShopCartBlock(YES,resultDic[@"msg"]);
        }else{
            adjustShopCartBlock(NO,resultDic[@"msg"]);
        }
        
    }];

    
}
@end
