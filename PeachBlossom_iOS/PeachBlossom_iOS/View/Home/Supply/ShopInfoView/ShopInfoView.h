//
//  ShopInfoView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ShopInfoViewDelegate <NSObject>

- (void)enterShopController;

@end


@interface ShopInfoView : UIView<ShopInfoViewDelegate>

@property (nonatomic, weak) id<ShopInfoViewDelegate> delegate;


//店铺图标  名称  等级  货品  服务  物流  店铺标签

- (void)_initShopInfoWithInfo:(UIImage *)shopimg
                     shopname:(NSString *)name
                    shopgrade:(NSString *)grade
                      grade_1:(NSString *)grade_1
                      grade_2:(NSString *)grade_2
                      grade_3:(NSString *)grade_3
                       tagArr:(NSArray *)tagarr;

- (IBAction)showShopBtnClicked:(id)sender;



@end

NS_ASSUME_NONNULL_END
