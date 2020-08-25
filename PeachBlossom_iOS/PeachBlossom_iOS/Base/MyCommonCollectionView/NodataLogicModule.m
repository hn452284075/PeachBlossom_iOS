//
//  NodataLogicModule.m
//  YilidiBuyer
//
//  Created by mm on 16/12/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "NodataLogicModule.h"

@implementation NodataLogicModule

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodataAlertTitle = @"暂无数据";
        self.nodataBgColor = [UIColor whiteColor];
        self.nodataAlertImage = @"空数据页状态";
        self.needDealNodataCondition = YES;
    }
    return self;
}

@end
