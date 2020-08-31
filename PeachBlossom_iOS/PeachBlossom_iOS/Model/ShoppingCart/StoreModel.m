//
//  StoreModel.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
       
        self.storeTitle = dic[@"seller_name"];
        self.listArr = [[GoodsModel objectGoodsModelWithGoodsArr:dic[@"goods_list"]] mutableCopy];
        self.storeImage = dic[@"avatar"];
        self.storeId = dic[@"seller_id"];
        self.is_rented = dic[@"is_rented"];
    }
    return self;
}
@end


@implementation StoreModel (objectStoreModel)

+ (NSMutableArray *)objectStoreModelWithStoreArr:(NSArray *)storeArr
{

    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:storeArr.count];
    for (NSDictionary *dic in storeArr) {
        StoreModel *model = [[StoreModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    
    return tempArr;
}

@end
