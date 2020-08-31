//
//  ShopCartViewController.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 17/7/18.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "BaseViewController.h"
 
@interface ShopCartViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIButton *allSeletedBtn;
@property (strong, nonatomic) IBOutlet UILabel *totalMoney;
@property (strong, nonatomic) IBOutlet UIButton *settlementBtn;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *freightLabel;

@end
