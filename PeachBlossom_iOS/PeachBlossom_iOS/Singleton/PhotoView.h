//
//  PhotoView.h
//  BloodSugar-Patient
//
//  Created by 曾勇兵 on 2020/7/9.
//  Copyright © 2020 wangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SeletecdIndexBlock)(NSInteger index);
@interface PhotoView : NSObject
+ (instancetype)photoManager;
- (void)seletecdIndexBlock:(SeletecdIndexBlock)seletecdIndexBlock;
@property (nonatomic,strong)UIView *viewBG;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,copy)SeletecdIndexBlock seletecdIndexBlock;
@end

NS_ASSUME_NONNULL_END
