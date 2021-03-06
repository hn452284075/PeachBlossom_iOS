//
//  AFNHttpRequestOPManager+log.m
//  YilidiBuyer
//
//  Created by mm on 17/1/22.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+log.h"
#import "NSObject+SUIAdditions.h"
const void *apiInfoKey = @"apiInfoKey";

@implementation AFNHttpRequestOPManager (log)

+(void)logWithRequestParam:(NSDictionary *)requestParam
                requestUrl:(NSString *)requestUrl
{

//    DDLogVerbose(@"请求头HttpHeaders---%@",[[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders]);
//    DDLogVerbose(@"请求参数param---%@",requestParam);
//    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,requestUrl];
//    DDLogVerbose(@"请求url---%@",requestUrlStr);
    NSString *requestUrlName = [[self class] apiNameOfUrl:requestUrl];
    NSLog(@"正在请求接口%@...",requestUrlName);
    

}

+(void)logWithResponseObject:(id)responseObj
                htppResponse:(NSHTTPURLResponse *)htppResponse
           responseErrorInfo:(NSError *)responseErrorInfo
                  requestUrl:(NSString *)requestUrl
                requestParam:(NSDictionary *)requestParam
{

    NSString *requestUrlName = [[self class] apiNameOfUrl:requestUrl];
    NSLog(@"<======================请求接口%@信息===========================>",requestUrlName);
    NSLog(@"请求头HttpHeaders---%@",[[[[self class] sharedManager] requestSerializer] HTTPRequestHeaders]);
    NSString *requestUrlStr = [NSString stringWithFormat:@"%@%@",BASEURL,requestUrl];
    NSLog(@"请求url---%@",requestUrlStr);
    NSLog(@"请求参数param---%@",requestParam);
    NSLog(@"响应头HttpHeaders---%@",htppResponse.allHeaderFields);
    NSLog(@"响应结果result---%@",responseObj[@"msg"]);
    NSInteger errorCode = responseErrorInfo.code;
    if (errorCode != 1) {
        NSLog(@"errorInfo ==> [error url = %@,code = %ld,msg --- %@]",requestUrlStr,responseErrorInfo.code,responseErrorInfo.localizedDescription);
        if (errorCode == -1) {
            NSLog(@"status code -- %ld",htppResponse.statusCode);
            NSLog(@"status code 描述-- %@",[NSHTTPURLResponse localizedStringForStatusCode:htppResponse.statusCode]);
        }
    }else {
        NSLog(@"errorInfo ==> null");
    }
    NSLog(@"<============================请求结束=============================>");


}

+ (NSString *)apiNameOfUrl:(NSString *)url {
    
    NSString *urlName = nil;
    AFNHttpRequestOPManager *manager = [self sharedManager];
    NSDictionary *apiInfos =  [manager sui_getAssociatedObjectWithKey:apiInfoKey];
    if (isEmpty(apiInfos) || !apiInfos.count) {
        NSDictionary *apiInfos = [[self class] apiUrlInfoDic];
        [manager sui_setAssociatedCopyObject:apiInfos key:apiInfoKey];
    }
    
    urlName = apiInfos[url][@"apiName"];
    if (isEmpty(urlName)) {
        urlName = url;
    }
    return urlName;
}

+ (NSDictionary *)apiUrlInfoDic {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ApiInfo" ofType:@"plist"];
    NSDictionary *apiDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return apiDic;
}






@end
