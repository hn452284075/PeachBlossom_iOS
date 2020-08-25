//
//  DLHttpRequestManager.m
//  YilidiSeller
//
//  Created by yld on 16/3/23.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "AFNHttpRequestOPManager+ExternParams.h"
#import "AFNHttpRequestOPManager+errorHandle.h"
//#import "AFNHttpRequestOPManager+setCookes.h"
#import "AFNHttpRequestOPManager+log.h"
static AFNHttpRequestOPManager *_shareAFNHttpRequestOPManager = nil;


@implementation AFNHttpRequestOPManager

+ (instancetype)sharedManager{
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareAFNHttpRequestOPManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    
        _shareAFNHttpRequestOPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/png",@"image/jpeg", nil];
//        _shareAFNHttpRequestOPManager.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
        _shareAFNHttpRequestOPManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _shareAFNHttpRequestOPManager.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
        _shareAFNHttpRequestOPManager.securityPolicy.validatesDomainName = NO;//是否验证域名
        // 设置超时时间
//        [_shareAFNHttpRequestOPManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        _shareAFNHttpRequestOPManager.requestSerializer.timeoutInterval = 15.0f;
//        [_shareAFNHttpRequestOPManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//        _shareAFNHttpRequestOPManager.requestSerializer.HTTPShouldHandleCookies = NO;
    });
    return _shareAFNHttpRequestOPManager;
}

#pragma mark -- post method
+ (void )postWithParameters:(NSDictionary *)Parameters
                     subUrl:(NSString *)suburl
                      block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    
//    [[self class] setSessionIdCookie];
    [[self class] checkNetWorkStatus];
//    [[self class] logWithRequestParam:Parameters requestUrl:suburl];
    
    //加密操作
//    NSDictionary *dealedParam = [[self class] dealEntryParam:Parameters];
    
//    NSLog(@"dealedParam%@",dealedParam);
    [[[self class] sharedManager] POST:BASEURL parameters:Parameters
                               success:^(NSURLSessionDataTask *task,id responseObject) {
                                   

                                   NSError *responseError = nil;
                                  [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:suburl];
                                   
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                   
                                   [[self class] logWithResponseObject:responseObject htppResponse:response responseErrorInfo:responseError requestUrl:suburl requestParam:Parameters];

                                           if (block && responseObject) {
                                               block(responseObject,responseError);
                                           }
      
                                   
                               }failure:^(NSURLSessionDataTask *task,NSError *error) {
                                   [[self class] handError:&error withResponse:nil ofRequestUlr:suburl];
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                   NSDictionary *errorUserInfo = @{NSLocalizedDescriptionKey:error.localizedDescription};
                                   error = [NSError errorWithDomain:@"请求服务器出错" code:-1 userInfo:errorUserInfo];
                                   [[self class] logWithResponseObject:nil htppResponse:response responseErrorInfo:error requestUrl:suburl requestParam:Parameters];
                                   if (block) {
                                       block(@{@"msg":@"数据加载失败"},error);
                                   }
                               }];
}


+ (void)getInfoWithSubUrl:(NSString *)subUrl
               parameters:(NSDictionary *)Parameters
                    block:(void (^)(id result, NSError *error))block{
    [[self class] checkNetWorkStatus];
    
    NSLog(@"url = %@",[NSString stringWithFormat:@"%@%@",BASEURL,subUrl]);
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,subUrl];
    //加密
//    NSDictionary *dealedParam = [[self class] dealEntryParam:Parameters];
    
    [[[self class] sharedManager] GET:requestUrlStr parameters:Parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        responseObject = [[self class] tranferToNormalResultWithTheBase64Result:responseObject];
        NSError *responseError = nil;
        [[self class] handError:&responseError withResponse:responseObject ofRequestUlr:subUrl];
        if (block && responseObject) {
            block(responseObject,responseError);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error.description);
        [[self class] handError:&error withResponse:nil ofRequestUlr:subUrl];
        if (block) {
            block(nil,error);
        }
    }];
    
}

+ (NSDictionary *)dealEntryParam:(NSDictionary *)entryParam {
    NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (entryParam) {
        [newParamDic addEntriesFromDictionary:entryParam];
    }

    [newParamDic setObject:@"2" forKey:@"appid"];
    [newParamDic setObject:@"ios" forKey:@"platform"];
    [newParamDic setObject:[[self class]_MD5Encryption:[newParamDic copy]] forKey:@"sign"];
   
    
  
    return [newParamDic copy];
}

+ (NSString  *)dealMd5:(NSDictionary *)entryParam {
    
   NSString *str=  [[self class]_MD5Encryption:entryParam];
    return str;
    
}

#pragma mark 取消网络请求
+ (void)cancelRequest{
    NSLog(@"cancelRequest");
    [[[[self class] sharedManager] operationQueue] cancelAllOperations];
    
}


@end

