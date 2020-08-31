//
//  GoodsModel.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/29.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "GoodsModel.h"
#import "GlobeMaco.h"
@implementation GoodsModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
//        self.goodsId = dic[@"goodsId"];
//        self.goodsName = dic[@"goodsName"];
//        self.desc = dic[@"desc"];
//        self.goodsNumber = dic[@"goodsNumber"];
//        self.goodsOriginalPrice =dic[@"goodsOriginalPrice"];
//        self.goodsImg = dic[@"goodsImg"];

      
        self.distance = dic[@"distance"];
        self.goodsName = dic[@"goods_name"];
        self.goodsPrice = dic[@"goods_price"];
        self.goodsThumb = dic[@"goods_thumb"];
        self.goodsId = dic[@"id"];
        self.shortDesc = dic[@"short_desc"];
        self.stockNum = dic[@"stock"];
        self.storeId = dic[@"store_id"];
        self.type = dic[@"type"];
        self.storeName = dic[@"store_name"];
        self.unit = dic[@"unit"];
        self.shipping_cost = dic[@"shipping_cost"];
        self.shipping_from = dic[@"shipping_from"];
        self.specialPrice = [NSString stringWithFormat:@"%@",dic[@"special_price"]];
        self.goodsOriginalPrice = dic[@"special_price"];
        self.goodsNumber = dic[@"goods_num"];
        self.valid = @1;
        self.productId = [NSString stringWithFormat:@"%@",dic[@"goods_id"]];
        self.is_feedback = dic[@"is_feedback"];
        self.is_aftersale = dic[@"is_aftersale"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeShopCartGoodsEditState:) name:EditorGoodsCenter object:nil];
        self.isLease = dic[@"is_rented"];
        self.leaseContent = dic[@"rent_introduce"];
        self.rent_cost = [NSString stringWithFormat:@"￥%@",dic[@"rent_cost"]]; 
        
    }
    return self;
}

- (CGFloat)leaseTextHeight{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.leaseContent];
    NSRange range =  NSMakeRange(0,[self.leaseContent length]);
    [attributedString addAttribute:NSFontAttributeName value:kSystemFontSize(13) range:range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    CGFloat textHeight  = [attributedString boundingRectWithSize:CGSizeMake(kScreenWidth-10, 9999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    JLog(@"leaseTextHeight%f",textHeight);
    return textHeight;
    
}

#pragma mark - EditorGoodsCenter
- (void)observeShopCartGoodsEditState:(NSNotification *)notification{
    BOOL isShopCartEditing = [(NSNumber *)notification.object integerValue];
    if (self.isValid) {
        return;
    }

    self.editing = isShopCartEditing;
    if (!isShopCartEditing) {
        self.selected = NO;
    }
   
}
@end

@implementation GoodsModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    
    return [tempArr copy];
}
@end
