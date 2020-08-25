//
//  UserModel.m
//  PeachBlossom_iOS
//
//  Created by 曾勇兵 on 2020/8/15.
//  Copyright © 2020 zengyongbing. All rights reserved.
//

#import "UserModel.h"
#import "TMCache.h"
static UserModel *_userDataManager = nil;
@implementation UserModel
+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _userDataManager = [[UserModel alloc] init];
        
    });
    
    return _userDataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
         self.userInfo =   (NSMutableDictionary *)  [[TMCache sharedCache]objectForKey:userInfoCacheKey];
        
       
    }
    return self;
}

- (void)clearUserInfo {
    self.userInfo = @{}.mutableCopy;
    [[TMCache sharedCache]removeAllObjects];
    
}

- (NSDictionary *)userInfo {
    
    return _userInfo;
    
}
 
 
-(NSString *)userId{
    
    return [NSString isEmptyForString:_userInfo[@"id"]];
}
-(NSString *)username{
    
    return [NSString isEmptyForString:_userInfo[@"username"]];
}
-(NSString *)phone{
    
    return [NSString isEmptyForString:_userInfo[@"phone"]];;
}
-(NSString *)avatar{
    
    return [NSString isEmptyForString:_userInfo[@"avatar"]];;
}
 
 
- (void)saveUserInfo:(NSMutableDictionary *)userInfo {
 
   _userInfo = userInfo;
    [[TMCache sharedCache]setObject:_userInfo forKey:userInfoCacheKey];
}


- (BOOL)userIsLogin {
    
    if (isEmpty(self.userInfo)) {
        return NO;
    }else {
        return YES;
    }
}
@end
