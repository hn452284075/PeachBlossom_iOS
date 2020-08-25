//
//  PayResponseBaseModel.h
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"


typedef NS_ENUM(NSInteger,PayResult) {
    PayResult_Success,
    PayResult_Failed,
    PayResult_Canceled,
};
typedef NS_ENUM(NSInteger,PayType) {
    PayType_Alipay,
    PayType_WxPay,
};
/**
 *  支付结果基类
 */
@interface PayResponseBaseModel : BaseModel

@property (nonatomic,assign)PayResult payResult;

@property (nonatomic,assign)PayType payType;

@property (nonatomic,copy)NSString *payTypeStr;

@property (nonatomic,assign)NSInteger statusCode;

@property (nonatomic,copy)NSString *statusStr;

@end
