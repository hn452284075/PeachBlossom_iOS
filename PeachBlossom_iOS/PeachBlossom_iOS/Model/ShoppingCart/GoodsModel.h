//
//  GoodsModel.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsModel : BaseModel


@property (nonatomic,copy)NSString *distance;//距离
@property (nonatomic,copy)NSString *goodsName;//产品名
@property (nonatomic,copy)NSString *goodsPrice;//产品价格
@property (nonatomic,copy)NSString *specialPrice;//产品特价
@property (nonatomic,copy)NSString *goodsThumb;//产品图片
@property (nonatomic,copy)NSString *goodsId;//首页产品id
@property (nonatomic,copy)NSString *productId;//购物车产品id----我也很绝望，同样的产品分了两个id
@property (nonatomic,copy)NSString *shortDesc;//产品简述
@property (nonatomic,copy)NSString *stockNum;//产品库存
@property (nonatomic,copy)NSString *shipping_cost;//运费
@property (nonatomic,copy)NSString *shipping_from;//发货地
@property (nonatomic,copy)NSString *storeId;//合伙人ID （0为C端用户，1为自营，其他为合伙人）
@property (nonatomic,copy)NSString *type;//合伙人ID （0为C端用户，1为自营，其他为合伙人）
@property (nonatomic,copy)NSString *storeName;//合伙人店铺名
@property (nonatomic,copy)NSString *unit;//商品单位 个，部，台
@property (nonatomic,copy)NSNumber *goodsNumber;//产品数
@property (nonatomic,copy)NSNumber *isLease;//是否可租
@property (nonatomic,copy)NSString *leaseContent;//租用说明
@property (nonatomic,copy)NSString *rent_cost;//租金价格
 
@property (nonatomic,copy)NSNumber *is_feedback;//是否评价
@property (nonatomic,copy)NSNumber *is_aftersale;//是否已经售后


 @property (nonatomic,assign)CGFloat leaseTextHeight;


#pragma mark - MODIFY
/**
 产品是否有效
 */
@property (nonatomic,getter=isValid)BOOL valid;
/**
 产品是否正在编辑
 */
@property (nonatomic,getter=isEditing)BOOL editing;


@property (nonatomic,copy)NSString *desc;
/**
// *  商品原价，没有经过任何打折和优惠的价格
// */
@property (nonatomic,strong)NSNumber *goodsOriginalPrice;

@end

@interface GoodsModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr;

@end
