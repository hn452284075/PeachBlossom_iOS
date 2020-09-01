//
//  StoreTopView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol StoreTopViewDelegate <NSObject>

- (void)gradeRuleFunction;
- (void)upGoodsFunction;
- (void)downGoodsFunction;

@end


@interface StoreTopView : UIView<StoreTopViewDelegate>

@property (nonatomic, weak) id<StoreTopViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)configTopViewName:(NSString *)name grade:(NSString *)grade upNumber:(int)uvalue downNumber:(int)dvalue;



@end

NS_ASSUME_NONNULL_END
