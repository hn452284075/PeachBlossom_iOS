//
//  UIImage+extern.h
//  YilidiSeller
//
//  Created by yld on 16/3/29.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extern)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

- (UIImage *)imageScaledToSize:(CGSize)size;

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

/**
 颜色转化为图片
 
 @param color 入参 颜色
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 等比例缩放图片 方法
 
 @param image 要缩放的 image
 @param scaleSize 缩放比例
 @return  缩放后的image
 */
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 保存图片到系统相册  （无法找到取出）
 
 @param image image
 */
+ (void)saveImageWithPhotoLibrary:(UIImage *)image;


/**
 获取系统相册中所有的缩略图 和原图
 缩略图  尺寸 大约 {32.5，60}   (allSmallImageArray 回调获取到的缩略图 图片数组)
 原图    尺寸 大约 屏幕等大     （allOriginalImageArray 回调获取到的大图 图片数组)
 
 */
+ (void)async_getLibraryPhoto:(void(^)(NSArray <UIImage *> *allSmallImageArray))smallImageCallBack
     allOriginalImageCallBack:(void(^)(NSArray <UIImage *> *allOriginalImageArray))allOriginalImageCallBack;



/**
 裁剪 图片
 
 @return image
 */
- (UIImage *)beginClip;
/**
 图片圆角化

@return image
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
 
@end
