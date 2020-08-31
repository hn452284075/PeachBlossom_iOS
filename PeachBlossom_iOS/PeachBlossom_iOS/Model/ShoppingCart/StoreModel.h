//
//  StoreModel.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "BaseModel.h"
#import "GoodsModel.h"
@interface StoreModel : BaseModel
@property (nonatomic, strong)NSMutableArray * listArr;
@property (nonatomic, copy)NSString * storeTitle;
@property (nonatomic, copy)NSString * storeImage;
@property (nonatomic, copy)NSString * storeId;
@property (nonatomic, copy)NSString * is_rented;//是否租用 1=租用 0=未租用
@property (nonatomic, assign)BOOL isChecked;//店铺被选中

//@property (nonatomic, assign)BOOL isSeleted;//店铺是否可以选中，商品无货时不可以店铺全选操作

@end

@interface StoreModel (objectStoreModel)

+ (NSMutableArray *)objectStoreModelWithStoreArr:(NSArray *)storeArr;

@end
