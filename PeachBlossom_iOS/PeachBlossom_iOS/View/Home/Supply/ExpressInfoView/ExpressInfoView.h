//
//  ExpressInfoView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/27.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ExpressInfoViewDlegate <NSObject>

- (void)expressInfoViewDismiss;

@end

@interface ExpressInfoView : UIView<ExpressInfoViewDlegate>

@property (nonatomic, weak) id<ExpressInfoViewDlegate> delegate;

- (IBAction)dismissInfoView:(id)sender;




@end

NS_ASSUME_NONNULL_END
