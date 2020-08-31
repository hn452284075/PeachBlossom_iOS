//
//  ShopCartHeaderView.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/25.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderViewBlock)(NSInteger index,BOOL isSeleted);

@class StoreModel;
@interface ShopCartHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong)StoreModel *model;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UIButton *seletedBtn;
@property (nonatomic,copy)HeaderViewBlock headerViewBlock;
@end
