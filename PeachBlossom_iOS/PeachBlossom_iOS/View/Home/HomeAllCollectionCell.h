//
//  HomeAllCollectionCell.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/20.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAllCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDesc;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIButton *addShopCart;
@property (nonatomic,strong)NSDictionary *dic;
@end
