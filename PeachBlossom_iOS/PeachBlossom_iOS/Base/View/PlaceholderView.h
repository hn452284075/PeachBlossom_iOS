//
//  PlaceholderView.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/8/28.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 占位图的类型 */
typedef NS_ENUM(NSInteger, PlaceholderViewType) {
    /** 没网 */
    PlaceholderViewTypeNoNetwork = 1,
//    /** 没订单 */
//    PlaceholderViewTypeNoOrder,
//    /** 没商品 */
//    PlaceholderViewTypeNoGoods,
//    /** 美丽的妹纸 */
//    PlaceholderViewTypeBeautifulGirl
};

#pragma mark - @protocol

@class PlaceholderView;

@protocol PlaceholderViewDelegate <NSObject>

/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(PlaceholderView *)placeholderView
   reloadButtonDidClick:(UIButton *)sender;

@end

#pragma mark - @interface

@interface PlaceholderView : UIView

/** 占位图类型（只读） */
@property (nonatomic, assign, readonly) PlaceholderViewType type;
/** 占位图的代理方（只读） */
@property (nonatomic, weak, readonly) id <PlaceholderViewDelegate> delegate;

/**
 构造方法
 
 @param frame 占位图的frame
 @param type 占位图的类型
 @param delegate 占位图的代理方
 @return 指定frame、类型和代理方的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame
                         type:(PlaceholderViewType)type
                     delegate:(id)delegate;

@end
