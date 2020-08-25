//
//  LoginViewController.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "LoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "Util.h"
@interface LoginViewController ()<TencentSessionDelegate>
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:kTencentAppId andDelegate:self];

}

//登陆完成调用
- (void)tencentDidLogin
{
    
    
//    self.openId =_tencentOAuth.openId;
//
//    if (_tencentOAuth.accessToken && _tencentOAuth.accessToken.length)
//    {
//        //  记录登录用户的OpenID、Token以及过期时间
//
//        JLog(@"Token:%@",_tencentOAuth.accessToken);
//        self.accessQQToken= _tencentOAuth.accessToken;
//        NSDictionary *dic = @{@"accessToken":self.accessQQToken,@"openId":self.openId};
////        [self wechatAndqqLogin:dic submiturl:kUrl_QQLogin];
//
//                [_tencentOAuth getUserInfo];
//    }
//    else
//    {
//        [Util ShowAlertWithOnlyMessage:@"登录不成功没有获取accesstoken"];
//
//    }
}
//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    
    if (cancelled)
    {
        [Util ShowAlertWithOnlyMessage:@"取消登录"];
        
    }else{
        
        [Util ShowAlertWithOnlyMessage:@"登录失败"];
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
   
    
    [Util ShowAlertWithOnlyMessage:@"无网络连接，请设置网络"];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams{
    return nil;
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    
    JLog(@"respons:%@",response.jsonResponse);
    JLog(@"respons:%@",response.jsonResponse[@"city"]);
    JLog(@"respons:%@",response.jsonResponse[@"nickname"]);
    JLog(@"respons:%@",response.jsonResponse[@"province"]);
    JLog(@"respons:%@",response.jsonResponse[@"gender"]);
    JLog(@"respons:%@",response.jsonResponse[@"figureurl"]);
    JLog(@"respons:%@",response.jsonResponse[@"figureurl_1"]);
    
   
 
    
}
 
@end
