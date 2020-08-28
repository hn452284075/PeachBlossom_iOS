//
//  SupplyGoodsInfoView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SupplyGoodsInfoDelegate <NSObject>

- (void)supply_share_Action;    //分享
- (void)supply_love_Action;     //收藏

@end

@interface SupplyGoodsInfoView : UIView<SupplyGoodsInfoDelegate>

- (void)_initGoodsTitleInfo:(NSString *)title price:(NSString *)price weight:(NSString *)weight distance:(NSString *)distance see:(NSString *)see;

@property (nonatomic, weak) id<SupplyGoodsInfoDelegate> delegate;

- (IBAction)supplyShareBtnClicked:(id)sender;

- (IBAction)supplyLoveBtnClciked:(id)sender;


@end

NS_ASSUME_NONNULL_END
