//
//  DeliveryShowView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/9/1.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeliveryBlock)(NSString *company,NSString*num);
@interface DeliveryShowView : UIView

@property (nonatomic,strong)UITextField *companyField;
@property (nonatomic,strong)UITextField *numField;
@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,copy)DeliveryBlock deliveryBlock;
-(instancetype)initWithDeliveryFrame:(CGRect)frame;
@end


