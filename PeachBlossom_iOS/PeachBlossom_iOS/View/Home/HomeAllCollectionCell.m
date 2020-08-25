//
//  HomeAllCollectionCell.m
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/20.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "HomeAllCollectionCell.h"
#import "UIImageView+sd_SetImg.h"
@implementation HomeAllCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.layer.cornerRadius=5;
    
}

- (void)setDic:(NSDictionary *)dic{
    //设置UIImageView的填充属性
    self.goodsImage.contentMode = UIViewContentModeScaleToFill;
 
}
@end
