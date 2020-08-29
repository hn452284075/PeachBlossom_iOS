//
//  AddToCartView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddToCartDelegate <NSObject>

- (void)addToCart_Ok:(int)selectedIndex;
- (void)addToCart_Cancel;

@end


@interface AddToCartView : UIView<AddToCartDelegate>

@property (nonatomic, weak) id<AddToCartDelegate> delegate;

- (void)_initCartViewInfo:(UIImage *)image price:(NSString *)price msg:(NSString *)msg specArr:(NSArray *)specarr;


- (IBAction)closeCartView:(id)sender;

- (IBAction)addToCart:(id)sender;



@end

NS_ASSUME_NONNULL_END
