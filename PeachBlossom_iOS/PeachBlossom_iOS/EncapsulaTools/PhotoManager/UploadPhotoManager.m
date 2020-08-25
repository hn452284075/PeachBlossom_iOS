//
//  TakePhotoUpdateImg.m
//  jingGang
//
//  Created by zyb on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UploadPhotoManager.h"
#import "ALActionSheetView.h"
#import "AFNetworking.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "Util.h"
#import "UIViewController+hub.h"
#import <CommonCrypto/CommonDigest.h>
#import "WPhotoViewController.h"
#import "BaseLoadingView.h"
@interface UploadPhotoManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy)GetPhotoBlock getphotoBlock;
@property (nonatomic, copy)UpdateImgBlock updateImgBlock;
@property (nonatomic, strong)UploadPhotoImgHandler *uploadPhotoImgHandler;

@property (nonatomic,weak) UIViewController *takePhotoVC;



@end

@implementation UploadPhotoManager

-(void)uploadPhoto:(GetPhotoBlock)getPhotoBlock upDateImg:(UpdateImgBlock)updateImgBlock
{
    _getphotoBlock = getPhotoBlock;
    _updateImgBlock = updateImgBlock;
    
    //弹出选择sheet
    [self _showPhotoSheet];


}

//-(void)updateImage:(UIImage *)image getImgurl:(UpdateImgBlock)updateImgBlock {
//    
//    _updateImgBlock = updateImgBlock;
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
////    [self _upLoadHeadImgWithImgData:imageData];
//
//}

-(void)_showPhotoSheet{
    
    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从相册中选择"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {//拍照
            [self showPickerWithType:UIImagePickerControllerSourceTypeCamera];
        }else if (buttonIndex == 1){//从相册中选
             if (self.isUpdateImg||self.isPostAingleImg) {
                [self showPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
             }else{

            WPhotoViewController *WphotoVC = [[WPhotoViewController alloc] init];
            //选择图片的最大数
            WphotoVC.selectPhotoOfMax = _selectPhotoOfMax;
            WEAK_SELF
            [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
//                _photosArr = phostsArr;
                NSLog(@"phostsArr%@",phostsArr);
                [weak_self _seletedPhoto:phostsArr];
            }];
            [self.takePhotoVC presentViewController:WphotoVC animated:YES completion:nil];
            }
        }else{//取消
            
        }
    }];
    
    [actionSheetView show];
}


- (void)_seletedPhoto:(NSMutableArray *)array{

    //只需要key进行MD5加密
    NSString *str =@"KwZp_2maUOYBOprPyh";
    //KwZp_2maUOYBOprPyh
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    
    [manager POST:PostImageURL parameters:@{@"sign":result} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
 
        // 上传 多张图片
        for(NSInteger i = 0; i < array.count; i++) {
            UIImage *image = [array[i]objectForKey:@"image"];
    #warning 这里图片上传上去之后，如果超过2M的话系统会默认旋转90°，这里处理这种情况
            image = [self fixOrientation:image];
            image =   [self useImage:image];
            NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
            NSString *str = @"file[]";
            NSString *fileName = [NSString stringWithFormat:@"%ld.png", (long)i];
            [formData appendPartWithFileData:imageData name:str fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress *_Nonnull uploadProgress) {
   
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
   
            
            if (self.getphotoBlock) {
               self.getphotoBlock(responseObject[@"data"][@"save"],responseObject[@"data"][@"succ"]);
            }
        
        
        if (self.isUpdateImg) {
            [self _upLoadHeadImgWithImg:responseObject[@"data"]];
        }
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        NSLog(@"error:%@",error);
    }];

    
}


#pragma mark - 上传图片 - 生成url
#pragma mark - 上传头像图片
-(void)_upLoadHeadImgWithImg:(NSDictionary *)imageDic{
    
    if (!isEmpty(imageDic[@"save"])||!isEmpty(imageDic[@"succ"])) {
        
    
        NSArray *pathArray = imageDic[@"save"];
        NSArray *urlArray =imageDic[@"succ"];
        [[BaseLoadingView sharedManager]show];
            WEAK_SELF
          NSDictionary *requestParam  = @{@"module":@"user",@"act":@"updateuserheadimg",@"user_id":@"",@"upload_path":pathArray[0]};
 
        [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:nil block:^(NSDictionary *resultDic, NSError *error) {
               
            [[BaseLoadingView sharedManager]dissmiss];
            if ([resultDic[@"errcode"] integerValue]==200) {
                
                
                NSLog(@"%@",resultDic);
                if (self.updateImgBlock) {
                    weak_self.updateImgBlock(urlArray[0],error);
                }
                
            }else{
                
                NSLog(@"%@",resultDic);
                if (self.updateImgBlock) {
                    weak_self.updateImgBlock(imageDic[@"data"][@"fail"],error);
                }
            }
            
        }];
        
    }

    
    
}


- (void)showPickerWithType:(UIImagePickerControllerSourceType)photoType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = photoType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self.takePhotoVC presentViewController:picker animated:YES completion:nil];
}

#pragma mark - image piker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    image =   [self useImage:image];
    //如果相机就保存图片
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self saveImage:image withName:[self currentDate]];
        });
    }
   
    
    JLog(@"原图 -- %@,大小 -- %ldkb",image,[self lengthOfImage:image]);
 
    [picker dismissViewControllerAnimated:YES completion:nil];
#warning 这里图片上传上去之后，如果超过2M的话系统会默认旋转90°，这里处理这种情况
    image = [self fixOrientation:image];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{@"image":image}]];
    [self _seletedPhoto:arr];
    
//    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    JLog(@"处理后上传图 -- %@,大小 -- %ldkb",image,[self lengthOfImage:image]);

#ifdef DEBUG
    
#else
    
#endif
}

- (NSDictionary *)dealEntryParam2:(NSDictionary *)entryParam {
    NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (entryParam) {
        [newParamDic addEntriesFromDictionary:entryParam];
    }
    
    //只需要key进行MD5加密
    NSString *str =@"KwZp_2maUOYBOprPyh";
    //KwZp_2maUOYBOprPyh
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    
    
    [newParamDic setObject:@"125230168" forKey:@"appid"];
    
    [newParamDic setObject:result forKey:@"sign"];
    
    
    
    return newParamDic;
}



- (NSString*)_encryptionMD5:(NSDictionary*)params{
    
    
    NSArray *keyArray = [params allKeys];
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        [valueArray addObject:[params objectForKey:sortString]];
    }
    
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArray[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    return sign;
    
}




- (UIImage *)useImage:(UIImage *)image {
    
    @autoreleasepool {
        JLog(@"原图 -- %@,大小 %ldkb",image,[self lengthOfImage:image]);
        // Create a graphics image context
        CGFloat imageCropPercent = 1.0f;
        if ([self lengthOfImage:image] > 800 ) {
            imageCropPercent = 2.0f;
        }
        CGSize newSize = CGSizeMake(image.size.width/imageCropPercent, image.size.height/imageCropPercent);
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this new context, with the desired
        // new size
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        // Get the new image from the context
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        JLog(@"压缩后 -- %@,大小 %ldkb",newImage,[self lengthOfImage:newImage]);

        // End the context
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
}

-(NSInteger)lengthOfImage:(UIImage *)image {
    
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    
    return [imageData length]/1024;
}


- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI); break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0); transform = CGAffineTransformScale(transform, -1, 1); break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;

}



//保存到本地图片
- (void) saveImage:(UIImage *)image withName:(NSString *)imageName {
    NSData *currentImage = UIImageJPEGRepresentation(image, 0.5);
    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"photoAlbum"];
    NSString *photoPath = [file stringByAppendingPathComponent:imageName];
    [currentImage writeToFile:photoPath atomically:YES];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

//设置照片的名称保存格式
- (NSString *) currentDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSString *imageFileName = [NSString stringWithFormat:@"%@.png", currentDateString];
    
    return imageFileName;
}

- (UIViewController *)takePhotoVC {
    
    if (!_takePhotoVC) {
        _takePhotoVC = [Util currentViewController];
    }
    return _takePhotoVC;

}

@end
