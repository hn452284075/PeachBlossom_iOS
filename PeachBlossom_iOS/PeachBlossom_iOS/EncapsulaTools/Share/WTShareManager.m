//
//  WTShareManager.m
//  WTShare
//
//  Created by Mac on 16/7/1.
//  Copyright © 2016年 wutong. All rights reserved.
//

#import "WTShareManager.h"
#import "WTShareContentItem.h"
#import "UIImage+extern.h"
#define kWTShareQQSuccess @"0"
#define kWTShareQQFail      @"-4"

@interface WTShareManager ()
 
@property (nonatomic, strong)WTShareResultlBlock shareResultlBlock;
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@end

@implementation WTShareManager

static WTShareManager * _instence;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [super allocWithZone:zone];
        [_instence setRegisterApps];
    });
    return _instence;
}
+ (instancetype)shareWTShareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [[self alloc]init];
        [_instence setRegisterApps];
    });
    return _instence;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instence;
}


// 注册appid
- (void)setRegisterApps
{
    // 注册Sina微博
//    [WeiboSDK registerApp:kSinaAppKey];
    // 微信注册
//    [WXApi registerApp:WxAppid];
    
    // 注册QQ
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:kTencentAppId andDelegate:self];
}



#pragma mark - 分享方法------
+ (void)wt_shareWithContent:(WTShareContentItem *)contentObj shareType:(WTShareType)shareType shareResult:(WTShareResultlBlock)shareResult
{
    WTShareManager * shareManager = [WTShareManager shareWTShareManager];
    shareManager.shareResultlBlock = shareResult;
    
    [self wt_shareWithContent:contentObj shareType:shareType];
}
+ (void)wt_shareWithContent:(WTShareContentItem *)contentObj shareType:(WTShareType)shareType
{
    [WTShareManager shareWTShareManager];
    
    switch (shareType) {
        case WTShareTypeWeiBo:
        {
//            WBMessageObject *message = [WBMessageObject message];
//            message.text = [NSString stringWithFormat:@"%@%@", contentObj.sinaSummary,contentObj.urlString];
//
//            if(contentObj.shareImage){
//                WBImageObject *webpage = [WBImageObject object];
//                webpage.imageData =  UIImageJPEGRepresentation(contentObj.shareImage, 1.0f);
//                message.imageObject = webpage;
//            }
//
//            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
//
//            [WeiboSDK sendRequest:request];
            break;
        }
        case WTShareTypeQQ:
        {
            NSString * shareTitle = [NSString string];
            shareTitle = contentObj.qqTitle ? contentObj.qqTitle : contentObj.title;
            
            if (!isEmpty(contentObj.urlString)) {
                //分享跳转URL
                NSString *urlt = contentObj.urlString;
                QQApiNewsObject * newsObj ;
                newsObj   = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlt] title:shareTitle description:contentObj.summary previewImageURL:[NSURL URLWithString:contentObj.urlImageString]];
                
                
                SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
                //将内容分享到qq
                [QQApiInterface sendReq:req];
            }else{
                UIImage *image = [[self class] seletedImage:contentObj.shareImage];
               
                NSData * imageData = UIImagePNGRepresentation(image);
                QQApiImageObject *imgObj =[QQApiImageObject objectWithData:imageData previewImageData:imageData title:@"" description:@""];
                
                SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
                
                //将内容分享到qq
               [QQApiInterface sendReq:req];
                
              
                
            }
          

        
  
            break;
            
        }
        case WTShareTypeQQZone://qq空间不支持分享纯图片
        {
            //分享跳转URL
            NSString *urlt = contentObj.urlString;
              QQApiNewsObject * newsObj ;
            if (!isEmpty(contentObj.urlString)) {
              
                newsObj   = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlt] title:contentObj.title description:contentObj.summary previewImageURL:[NSURL URLWithString:contentObj.urlImageString]];
              
            }else {

                 newsObj   = [QQApiNewsObject objectWithURL:[NSURL URLWithString:contentObj.urlImageString] title:@"优鲜共享" description:@"" previewImageURL:[NSURL URLWithString:contentObj.urlImageString]];
            }
            SendMessageToQQReq *req = [[SendMessageToQQReq alloc]init];
            req.message = newsObj;
            req.type = ESENDMESSAGETOQQREQTYPE;
            
            [QQApiInterface SendReqToQZone:req];
            
            break;
      
        }
        case WTShareTypeWeiXinTimeline: // 微信朋友圈
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.weixinPyqtitle.length >0 ? contentObj.weixinPyqtitle : contentObj.title;
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            if (!isEmpty(contentObj.urlString)) {
                WXWebpageObject * ext = [WXWebpageObject object];
                ext.webpageUrl = contentObj.urlString;
                message.mediaObject = ext;
            }else{
                WXImageObject *ext = [WXImageObject object];
                ext.imageData =  UIImagePNGRepresentation(contentObj.shareImage);
                 message.mediaObject = ext;
            }
            
         
            SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];

            
            break;
        }
        case WTShareTypeWeiXinSession:
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.title;
            
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
           
            
            if (!isEmpty(contentObj.urlString)) {
                WXWebpageObject * ext = [WXWebpageObject object];
                ext.webpageUrl = contentObj.urlString;
                message.mediaObject = ext;
            }else{
                WXImageObject *ext = [WXImageObject object];
                ext.imageData =  UIImagePNGRepresentation(contentObj.shareImage);
                message.mediaObject = ext;
            }
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
            
            break;
        }
        case WTShareTypeWeiXinFavorite:
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.title;
            
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            WXWebpageObject * ext = [WXWebpageObject object];
            ext.webpageUrl = contentObj.urlString;
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneFavorite;
            [WXApi sendReq:req];
            break;
        }
    
        default:
            break;
    }
}

 
#pragma mark - WeiboSDKDelegate 从新浪微博那边分享过来传回一些数据调用的方法
/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
//- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{}
///**
// 收到一个来自微博客户端程序的响应
//
// 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
// @param response 具体的响应对象
// */
//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
//{
//    /**
//
//     WeiboSDKResponseStatusCodeSuccess               = 0,//成功
//     WeiboSDKResponseStatusCodeUserCancel            = -1,//用户取消发送
//     WeiboSDKResponseStatusCodeSentFail              = -2,//发送失败
//     WeiboSDKResponseStatusCodeAuthDeny              = -3,//授权失败
//     WeiboSDKResponseStatusCodeUserCancelInstall     = -4,//用户取消安装微博客户端
//     WeiboSDKResponseStatusCodePayFail               = -5,//支付失败
//     WeiboSDKResponseStatusCodeShareInSDKFailed      = -8,//分享失败 详情见response UserInfo
//     WeiboSDKResponseStatusCodeUnsupport             = -99,//不支持的请求
//     WeiboSDKResponseStatusCodeUnknown               = -100,
//     */
//
//    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
//        //NSLog(@"微博----分享成功!!!");
//
//        self.shareResultlBlock(@"分享成功");
//    }else if(response.statusCode == WeiboSDKResponseStatusCodeUserCancel)
//    {
////        NSLog(@"微博----用户取消发送");
//
//
//        self.shareResultlBlock(@"用户取消发送");
//    }else if (response.statusCode == WeiboSDKResponseStatusCodeSentFail){
////        NSLog(@"微博----发送失败!");
//
//
//        self.shareResultlBlock(@"发送失败!");
//    }
//
//
////    NSLog(@"%@", response);
//}


#pragma mark - WXApiDelegate 从微信那边分享过来传回一些数据调用的方法


/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
//-(void) onResp:(BaseResp*)resp
//{
//    
//    // 成功回来
//    // errCode  0
//    // type     0
//    
//    // 取消分享回来
//    // errCode -2
//    // type 0
//    
//    if (resp.errCode == WTShareWeiXinErrCodeSuccess) {
////        NSLog(@"微信----分享成功!!");
//        self.shareResultlBlock(@"微信----分享成功!!");
//    }else{
////        NSLog(@"微信----用户取消分享!!");
//        self.shareResultlBlock(@"微信----用户取消分享!!");
//    }
////    NSLog(@"%@", resp);
//     
//}

#pragma mark - 判断qq是否分享成功
+ (void)didReceiveTencentUrl:(NSURL *)url
{
    NSString * urlStr = url.absoluteString;
    NSArray * array = [urlStr componentsSeparatedByString:@"error="];
    if (array.count > 1) {
        NSString * lastStr = [array lastObject];
        NSArray * lastStrArray = [lastStr componentsSeparatedByString:@"&"];
        
        NSString * resultStr = [lastStrArray firstObject];
        if ([resultStr isEqualToString:kWTShareQQSuccess]) {
//            NSLog(@"QQ------分享成功!");
            [WTShareManager shareWTShareManager].shareResultlBlock(@"分享成功");
          
        }else if ([resultStr isEqualToString:kWTShareQQFail]){
//            NSLog(@"QQ------分享失败!");
            [WTShareManager shareWTShareManager].shareResultlBlock(@"分享失败");
            
        }
        
    }
     
}

//qq分享图片限制了内容大小
+ (UIImage *)seletedImage:(UIImage *)image {
    
    @autoreleasepool {
      JLog(@"原图 -- %@,大小 %ldkb",image,[self lengthOfImage:image]);
        // Create a graphics image context
        CGFloat imageCropPercent = 1.0f;
        if ([self lengthOfImage:image] > 500 ) {
            imageCropPercent = 2.0f;
             image =    [[self class] reduceImage:image percent:0.3];
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

+(NSInteger)lengthOfImage:(UIImage *)image {
    
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    
    return [imageData length]/1024;
}

+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
@end
