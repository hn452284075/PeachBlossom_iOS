//
//  UserModel.h
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : BaseModel
// 用户ID
@property (nonatomic, strong) NSString *userId;
// 用户名
@property (nonatomic, strong) NSString *username;
// 手机号
@property (nonatomic, strong) NSString *phone;
// 头像url
@property (nonatomic, strong) NSString *avatar;

@property (nonatomic,strong)NSMutableDictionary *userInfo;

+ (instancetype)sharedInstance;

- (BOOL)userIsLogin;

- (void)saveUserInfo:(NSMutableDictionary *)userInfo;

- (void)clearUserInfo;


@end

NS_ASSUME_NONNULL_END
