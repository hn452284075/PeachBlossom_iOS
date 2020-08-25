//
//  NodataLogicModule.h
//  YilidiBuyer
//
//  Created by mm on 16/12/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NodataLogicModule : NSObject

@property (nonatomic,copy)NSString *nodataAlertTitle;

@property (nonatomic,copy)NSString *nodataAlertImage;

@property (nonatomic,copy)UIColor *nodataBgColor;
//空数据时是否需要默认图
@property (nonatomic,assign)BOOL needDealNodataCondition;


@end
