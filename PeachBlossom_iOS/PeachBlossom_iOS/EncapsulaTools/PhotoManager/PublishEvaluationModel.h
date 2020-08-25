//
//  PublishEvaluationModel.h
//  ZuziFresh_ios
//
//  Created by 曾勇兵 on 2017/7/28.
//  Copyright © 2017年 zengyongbing. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface PublishEvaluationModel : BaseModel
@property (nonatomic,strong)UIImage *commentPhotoImg;

@property (nonatomic,copy)NSString *commentPhotoImageUrl;

@property (nonatomic,copy)NSString *commentPhotoPath;

@property (nonatomic,assign)BOOL isAddPhoto;




@property (nonatomic,strong)NSMutableArray *commentImages;

@property (nonatomic,assign)CGFloat commentTotalHeight;

@property (nonatomic,assign)CGFloat commentPhotoPartHeight;

- (instancetype)init;

@end
