//
//  WPhotoViewController.h
//  photoDemo
//
//  Created by wangxinxu on 2017/6/1.
//  Copyright © 2017年 wangxinxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "myPhotoCell.h"
#import "UIImage+fixOrientation.h"
#import "WPMacros.h"
#import "WPFunctionView.h"
#import "NavView.h"
//#import "ZZTailoringVC.h"
@interface WPhotoViewController : BaseViewController
@property (nonatomic,strong)NSString *qrCodeUrl;
@property (nonatomic,strong)NSArray *dataArr;
@property (assign, nonatomic) NSInteger selectPhotoOfMax;/**< 选择照片的最多张数 */

/** 回调方法 */
@property (nonatomic, copy) void(^selectPhotosBack)(NSMutableArray *photosArr);

@end
