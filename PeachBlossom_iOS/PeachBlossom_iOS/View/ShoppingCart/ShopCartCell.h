//
//  ShopCartCell.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/25.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAndSubtractButton.h"

typedef void(^SeletedBlock)(UITableViewCell *cell);
typedef void(^GoodsNumBlock)(UITableViewCell *cell,NSNumber *num,NSString *addSub);

@class GoodsModel;
@interface ShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AddAndSubtractButton *addSubtractButton;
@property (weak, nonatomic) IBOutlet UIButton *seletedaBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeft;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *goodsName;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *rented;

@property (nonatomic,strong)GoodsModel *model;
@property (nonatomic,copy)SeletedBlock seletedBlock;
@property (nonatomic,copy)GoodsNumBlock goodsNumBlock;
@end
