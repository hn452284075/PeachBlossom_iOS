//
//  WaitingPayAddressView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaitingPayAddressView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeViewHeight;//店铺view高度
@property (weak, nonatomic) IBOutlet UIButton *deliveryBtn;//发货

@end

NS_ASSUME_NONNULL_END
