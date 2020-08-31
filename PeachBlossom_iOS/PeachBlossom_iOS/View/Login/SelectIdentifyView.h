//
//  SelectIdentifyView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelectIdentifyDelegate <NSObject>

- (void)disMissIdentifyView;
- (void)confirmInfoIdentifyName:(NSString *)name identify:(NSString *)iname;

@end

@interface SelectIdentifyView : UIView<SelectIdentifyDelegate>

@property (nonatomic, weak) id<SelectIdentifyDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame identifyArr:(NSArray *)iArr;

@end

NS_ASSUME_NONNULL_END
