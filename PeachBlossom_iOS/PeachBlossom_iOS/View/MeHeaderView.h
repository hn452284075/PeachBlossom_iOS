//
//  MeHeaderView.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/25.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *goodsBtn;
@property (weak, nonatomic) IBOutlet UIView *storeBtn;
@property (weak, nonatomic) IBOutlet UIView *recordBtn;
@property (weak, nonatomic) IBOutlet UIButton *certificationBtn;

@end

NS_ASSUME_NONNULL_END
