//
//  ProcurementCell.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/26.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonTitleBlock)(NSString * _Nullable str);
NS_ASSUME_NONNULL_BEGIN

@interface ProcurementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;//底部按钮父视图高度
@property (weak, nonatomic) IBOutlet UIView *bottomView;//底部按钮父视图
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTotal;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *orderImage;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (nonatomic,weak)NSDictionary *dic;
@property (nonatomic,copy)ButtonTitleBlock buttonTitleBlock;
@end

NS_ASSUME_NONNULL_END
