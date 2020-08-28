//
//  SearchGoodsCell.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/28.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchGoodsCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *content;

- (void)setTheLabeValueWithFont:(CGFloat)font textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius andContent:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
