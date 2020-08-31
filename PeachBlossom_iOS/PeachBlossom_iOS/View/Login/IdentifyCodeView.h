//
//  IdentifyCodeView.h
//  PeachBlossom_iOS
//
//  Created by rover on 2020/8/31.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CodeViewDelegate <NSObject>

- (void)disMissCodeView;
- (void)confirmCodeInfo:(NSString *)code;
- (void)getCodeAgin;

@end

@interface IdentifyCodeView : UIView<CodeViewDelegate>

@property (nonatomic, weak) id<CodeViewDelegate> delegate;


- (void)configViewTitle:(NSString *)title subTitle:(NSString *)subtitle defaultstr:(NSString *)dstr btnTitle:(NSString *)bstring hideFlag:(BOOL)flag;

- (IBAction)repeatGetCode:(id)sender;
- (IBAction)closeBtnClicked:(id)sender;
- (IBAction)okBtnClicked:(id)sender;


@end

NS_ASSUME_NONNULL_END
