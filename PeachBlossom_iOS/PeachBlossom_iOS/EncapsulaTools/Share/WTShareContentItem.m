//
//  WTShareContentItem.m
//  WTShare
//
//  Created by Mac on 16/7/1.
//  Copyright © 2016年 wutong. All rights reserved.
//

#import "WTShareContentItem.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
@implementation WTShareContentItem


+ (WTShareContentItem *)shareWTShareContentItem:(NSDictionary *)dic
{
    WTShareContentItem * item = [[WTShareContentItem alloc]init];
    if (isEmpty(dic[@"title"])) {
          item.title = @"";
    }else{
        
          item.title = dic[@"title"];
    }
  

    
    NSString *contentStr;
    if (isEmpty( dic[@"content"])) {
        contentStr = @"";
    }else{
        contentStr = dic[@"content"];
    }
    
    item.summary = contentStr;
    item.urlImageString = dic[@"img"];
    if (isEmpty(dic[@"url"])) {
        item.url =nil;
        item.urlString = @"";
    }else{
        
        item.url = [NSURL URLWithString:dic[@"url"]];
        
        item.urlString = dic[@"url"];
    }
   
    item.sinaSummary = contentStr;
    
    if (!isEmpty(dic[@"shareImage"])) {
        UIImage *share = dic[@"shareImage"];
        item.shareImage  = share;//图片必须压缩，否则不能跳转进行分享
        //缩略图
        item.thumbImage = [item imageByScalingAndCroppingForSize:CGSizeMake(item.shareImage.size.width/2, item.shareImage.size.height/2) withSourceImage:item.shareImage];
        
        return item;
    }
    if (item.urlImageString !=nil) {
        //先查找，存在就直接取缓存，不存在删除之前缓存的再下载
        if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.urlImageString]==nil) {
            [[SDImageCache sharedImageCache]clearMemory];
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager loadImageWithURL:[NSURL URLWithString:item.urlImageString] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (image) {
                    //原图
                    item.shareImage  = image;
                    
                    //缩略图
                    item.thumbImage = [item imageByScalingAndCroppingForSize:CGSizeMake(item.shareImage.size.width/2, item.shareImage.size.height/2) withSourceImage:item.shareImage];
          
                    
                }

            }];
            
            
        }else {
            
            //原图
            item.shareImage  = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.urlImageString];
            
            //缩略图
            item.thumbImage = [item imageByScalingAndCroppingForSize:CGSizeMake(item.shareImage.size.width/2, item.shareImage.size.height/2) withSourceImage:item.shareImage];
      
            
            
            
        }
        
        
    }else{
        
        
        item.thumbImage = [UIImage imageNamed:@"logo"];
        
        
    }

    return item;
}


- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


@end
