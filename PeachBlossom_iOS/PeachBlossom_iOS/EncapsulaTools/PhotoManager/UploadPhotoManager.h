//
//  TakePhotoUpdateImg.h
//  jingGang
//
//  Created by zyb on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UploadPhotoImgHandler.h"

//拍照或访问相册后得到的图片block
typedef void(^GetPhotoBlock)(NSMutableArray *imagePathArr,NSMutableArray *imageUrlArr);
//图片上传之后的回调block
typedef void(^UpdateImgBlock)(NSString *updateImgUrl, NSError *updateImgError);

@interface UploadPhotoManager : NSObject

-(void)uploadPhoto:(GetPhotoBlock)getPhotoBlock upDateImg:(UpdateImgBlock)updateImgBlock;

-(void)updateImage:(UIImage *)image getImgurl:(UpdateImgBlock)updateImgBlock;

@property (assign, nonatomic) NSInteger selectPhotoOfMax;/**< 选择照片的最多张数 */

@property (nonatomic,copy)NSString *uploadServerUlr;

@property (nonatomic,assign)BOOL allowPhotoEditing;

@property (nonatomic,assign)BOOL isUpdateImg;//是否更新头像

@property (nonatomic,assign)BOOL isPostAingleImg;//上传单张

@end
