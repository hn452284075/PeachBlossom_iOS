//
//  PublishImageCollectionCell.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/28.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DeleteImageBlock)(void);
@class PublishEvaluationModel;

@interface PublishImageCollectionCell : UICollectionViewCell
@property (nonatomic, strong)PublishEvaluationModel *model;
@property (nonatomic, strong)UIImageView *commentImgView;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, copy)DeleteImageBlock  deleteImageBlock;

@end
