//
//  AFNHttpRequestOPManager+ExternParams.m
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+ExternParams.h"
#import "Util.h"

@implementation AFNHttpRequestOPManager (ExternParams)

+ (NSDictionary *)setNormExternParamAtBaseParam:(NSDictionary *)baseParam
{
    NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (baseParam) {
        [newParamDic addEntriesFromDictionary:baseParam];
    }
//    NSString *deviceId = [[self class] _dealDeviceId];
    NSString *appBuidlVersion = [Util appVersion];
    NSNumber *appChannelNumber = @2;
    
//    [newParamDic setObject:deviceId forKey:@"deviceId"];
    [newParamDic setObject:appBuidlVersion forKey:@"versionCode"];
    [newParamDic setObject:appChannelNumber forKey:@"intfCallChannel"];

    return [newParamDic copy];
}




//+ (NSString *)_MD5Encryption:(NSDictionary *)dic {
//
//    NSString *strEncryption=  [NSString _encryptionMD5:dic];
//    
//    NSLog(@"md5:%@",strEncryption);
//    return strEncryption;
//    
//}

+ (NSDictionary *)setSpecitalExternParmOfVeryCode:(NSString *)veryCode
                                     atBaseParam:(NSDictionary *)baseParam
{

    NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithDictionary:baseParam];
    [newParamDic setObject:veryCode forKey:@"key"];
    return [newParamDic copy];
}


@end
