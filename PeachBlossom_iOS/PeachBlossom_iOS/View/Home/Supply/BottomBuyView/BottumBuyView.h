//
//  BottumBuyView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottumBuyViewDelegate <NSObject>

- (void)chat_action;
- (void)call_action;
- (void)cart_action;
- (void)addToCart_action;
- (void)buy_action;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BottumBuyView : UIView<BottumBuyViewDelegate>

@property (nonatomic, weak) id<BottumBuyViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
