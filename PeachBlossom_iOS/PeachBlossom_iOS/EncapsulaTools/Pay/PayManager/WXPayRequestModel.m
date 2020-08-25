//
//  WXPayRequestModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WXPayRequestModel.h"

@implementation WXPayRequestModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.appid = dic[@"appid"];
        self.noncestr = dic[@"noncestr"];
        self.package = dic[@"package"];
        self.partnerid = dic[@"partnerid"];
        self.prepayid = dic[@"prepayid"];
        self.timestamp = dic[@"timestamp"];
        self.sign = dic[@"sign"];
    }
    return self;
}

@end
